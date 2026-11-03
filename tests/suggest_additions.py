#!/usr/bin/env python3

"""
Compare BibTeX files from another folder with literatur.bib and suggest additions.

This script:
1. Parses all .bib files in a specified folder
2. Compares them with literatur.bib to find new entries
3. Formats suggestions according to literatur.bib conventions:
   - Sorted by key
   - Proper spacing (fields start at column 18)
   - Uses double quotes instead of curly braces for field values
   - Follows naming conventions for keys
"""

import argparse
import os
import re
import sys
import urllib.request
import urllib.parse
import xml.etree.ElementTree as ET
from pathlib import Path

import biblib.bib


def strip_latex_accents(text):
    """Strip LaTeX accent commands and replace with base letters.
    
    Handles patterns like:
      {\^e} -> e
      {\'a} -> a
      {\`o} -> o
      {\~n} -> n
      {\"u} -> u
      {\=a} -> a
      {\.a} -> a
      {\c{c}} -> c
      \'{e} -> e
      \'e -> e
    """
    s = str(text)
    # Handle {\ACCENT{LETTER}} e.g. {\c{c}}
    s = re.sub(r'\{\\[^a-zA-Z\s{}]\{([a-zA-Z])\}\}', r'\1', s)
    # Handle {\ACCENT LETTER} or {\ACCENTLETTER} e.g. {\'e}, {\^e}, {\"u}
    s = re.sub(r'\{\\[^a-zA-Z\s{}]\s*([a-zA-Z])\}', r'\1', s)
    # Handle \ACCENT{LETTER} e.g. \'{e}
    s = re.sub(r'\\[^a-zA-Z\s{}]\{([a-zA-Z])\}', r'\1', s)
    # Handle \ACCENTLETTER e.g. \'e
    s = re.sub(r'\\[^a-zA-Z\s{}]([a-zA-Z])', r'\1', s)
    # Handle named accent commands like {\aa} -> a, {\o} -> o, {\l} -> l
    s = re.sub(r'\{\\([a-zA-Z]+)\}', lambda m: m.group(1)[-1], s)
    return s


def parse_bib_files(file_paths):
    """Parse BibTeX files and return a dictionary of entries."""
    try:
        db = biblib.bib.Parser().parse(file_paths, log_fp=sys.stderr).get_entries()
        return db
    except biblib.messages.InputError as e:
        print(f"Error parsing BibTeX files: {e}", file=sys.stderr)
        sys.exit(1)


def get_original_entry_text(entry, file_paths):
    """Extract the original text of an entry from the source files."""
    # Read all source files to find the original entry
    for file_path in file_paths:
        try:
            with open(file_path, 'r') as f:
                content = f.read()
                # Look for the entry by its key
                # Match @Type{key, ... }
                pattern = rf'@\w+\{{{re.escape(entry.key)},.*?\n\}}'
                match = re.search(pattern, content, re.DOTALL)
                if match:
                    return match.group(0)
        except Exception:
            continue
    return None


def reformat_authors(author_str):
    """Reformat author names from "Last, First" to "First Last" format.
    
    Authors are delimited by " and ". Each author is checked:
    - If in "Last, First" format, convert to "First Last"
    - If already in "First Last" format, leave unchanged
    - Handles multiple authors separated by " and "
    - Wraps long author lists at ~80 chars with continuation at column 19
    """
    # Split by " and " (case-insensitive for safety), normalize whitespace
    authors = re.split(r'\s+and\s+', author_str.replace('\n', ' '), flags=re.IGNORECASE)
    reformatted = []
    for author in authors:
        author = author.strip()
        if ',' in author:
            # "Last, First" format -> "First Last"
            parts = author.split(',', 1)
            last = parts[0].strip()
            first = parts[1].strip()
            if first:
                reformatted.append(f"{first} {last}")
            else:
                reformatted.append(last)
        else:
            # Already "First Last" or single name, leave unchanged
            reformatted.append(author)
    
    # Join with " and ", wrapping at ~80 chars
    # The field value starts at column 19 (18 spaces indent for continuation)
    indent = " " * 18
    max_width = 80
    lines = []
    current_line = reformatted[0]
    for author in reformatted[1:]:
        candidate = current_line + " and " + author
        if len(indent) + len(candidate) > max_width:
            lines.append(current_line + " and")
            current_line = author
        else:
            current_line = candidate
    lines.append(current_line)
    return ("\n" + indent).join(lines)


def protect_title_caps(title):
    """Wrap words with mixed or non-sentence capitalization in {} to preserve case in BibTeX.
    
    In BibTeX, title case is controlled by the bibliography style. To preserve
    capitalization of specific words (e.g., acronyms, proper nouns), wrap them in {}.
    
    A word needs protection if it contains any uppercase letter that is NOT
    the first character of the word (i.e., mixed case like GPT, ChatGPT, ReAct).
    Also protects all-caps words like LLM, NLP, etc.
    
    Already-braced content (e.g., {GPT}) is left unchanged.
    """
    # Split into tokens, preserving spaces and punctuation
    # We process word by word, keeping track of braces
    result = []
    i = 0
    while i < len(title):
        # If we hit a '{', find the matching '}' and keep as-is (already protected)
        if title[i] == '{':
            depth = 0
            j = i
            while j < len(title):
                if title[j] == '{':
                    depth += 1
                elif title[j] == '}':
                    depth -= 1
                    if depth == 0:
                        break
                j += 1
            result.append(title[i:j+1])
            i = j + 1
        # If it's a word character, extract the full word
        elif title[i].isalpha() or title[i] in "-'":
            j = i
            while j < len(title) and (title[j].isalpha() or title[j] in "-'"):
                j += 1
            word = title[i:j]
            # Check if word needs protection:
            # - contains uppercase letter after position 0 (mixed case)
            # - is all-uppercase and length > 1 (acronym)
            needs_protection = False
            if len(word) > 1:
                # Check for uppercase after first char (mixed case like ChatGPT, ReAct)
                if any(c.isupper() for c in word[1:]):
                    needs_protection = True
                # Check for all-caps acronym (LLM, NLP, GPT)
                elif word.isupper():
                    needs_protection = True
            if needs_protection:
                result.append('{' + word + '}')
            else:
                result.append(word)
            i = j
        else:
            result.append(title[i])
            i += 1
    return ''.join(result)


def format_field(field_name, field_value, indent=2):
    """Format a BibTeX field according to literatur.bib conventions."""
    # Calculate spacing so values start at column 19 (1-indexed)
    # indent + field_name + " =  " + spaces = 18 (0-indexed)
    spaces_needed = 18 - indent - len(field_name) - 4  # 4 for " =  "
    spacing = " " * max(1, spaces_needed)
    
    # Clean up the field value
    value = str(field_value).strip()
    
    # Use double quotes instead of curly braces for the outer delimiters
    if value.startswith("{") and value.endswith("}"):
        value = '"' + value[1:-1] + '"'
    elif not (value.startswith('"') and value.endswith('"')):
        value = '"' + value + '"'
    
    # For title fields, protect mixed-case and all-caps words with {}
    if field_name == "title":
        # Strip outer quotes, protect caps, re-add quotes
        inner = value[1:-1]
        inner = protect_title_caps(inner)
        value = '"' + inner + '"'
    
    # For author/editor fields, reformat "Last, First" to "First Last"
    if field_name in ("author", "editor"):
        inner = value[1:-1]
        inner = reformat_authors(inner)
        value = '"' + inner + '"'
    
    return f"{' ' * indent}{field_name} = {spacing}{value}"


def is_arxiv_entry(entry):
    """Check if an entry is an arXiv preprint."""
    # Check if howpublished contains arxiv (works for any entry type)
    if "howpublished" in entry:
        howpublished = str(entry["howpublished"]).lower()
        if "arxiv" in howpublished:
            return True
    
    # Check if it's a Misc with eprint and archivePrefix fields (common arXiv format)
    if entry.typ.lower() == "misc" and "eprint" in entry:
        if "archiveprefix" in entry:
            archiveprefix = str(entry["archiveprefix"]).lower()
            if "arxiv" in archiveprefix:
                return True
        # Sometimes eprint alone indicates arXiv
        return True
    
    # Check if it's an article or misc with journal field
    if "journal" in entry:
        journal = str(entry["journal"]).lower()
        # Check for "arxiv preprint"
        if "arxiv" in journal and "preprint" in journal:
            return True
        # Check for journal = "ArXiv" or "CoRR" with volume containing arXiv ID
        if journal in ["arxiv", "corr"]:
            if "volume" in entry:
                volume = str(entry["volume"])
                # Check if volume looks like an arXiv ID (abs/YYMM.NNNNN)
                if "abs/" in volume or re.match(r'^\d{4}\.\d{4,5}$', volume):
                    return True
            return True
    
    return False


def extract_arxiv_id(entry):
    """Extract arXiv ID from various fields (journal, howpublished, eprint, volume)."""
    # Try eprint field first (most direct)
    if "eprint" in entry:
        eprint = str(entry["eprint"]).strip()
        # Remove any arXiv: prefix if present
        eprint = re.sub(r'^arXiv:', '', eprint, flags=re.IGNORECASE)
        # Check if it looks like an arXiv ID (YYMM.NNNNN format)
        if re.match(r'^\d{4}\.\d{4,5}$', eprint):
            return eprint
    
    # Try volume field (for journal = "ArXiv" or "CoRR")
    if "volume" in entry and "journal" in entry:
        journal = str(entry["journal"]).lower()
        if journal in ["arxiv", "corr"]:
            volume = str(entry["volume"]).strip()
            # Remove "abs/" prefix if present
            volume = re.sub(r'^abs/', '', volume)
            # Check if it looks like an arXiv ID
            if re.match(r'^\d{4}\.\d{4,5}$', volume):
                return volume
    
    # Try journal field (for @article entries with "arXiv preprint")
    if "journal" in entry:
        journal = str(entry["journal"])
        # Match patterns like "arXiv preprint arXiv:2303.08774" or "arXiv:2303.08774"
        match = re.search(r'arXiv:(\d+\.\d+)', journal, re.IGNORECASE)
        if match:
            return match.group(1)
    
    # Try howpublished field
    if "howpublished" in entry:
        howpublished = str(entry["howpublished"])
        match = re.search(r'arXiv:(\d+\.\d+)', howpublished, re.IGNORECASE)
        if match:
            return match.group(1)
    
    return None


def fetch_arxiv_metadata(arxiv_id):
    """
    Fetch metadata for an arXiv paper using the arXiv API.
    
    Args:
        arxiv_id: arXiv ID (e.g., "2303.08774")
    
    Returns:
        Dictionary with 'category' and 'comment' keys, or None if not found
    """
    if not arxiv_id:
        return None
    
    try:
        # arXiv API endpoint
        base_url = "http://export.arxiv.org/api/query"
        query = f"id_list={arxiv_id}"
        url = f"{base_url}?{query}"
        
        # Fetch the data
        with urllib.request.urlopen(url, timeout=5) as response:
            xml_data = response.read().decode('utf-8')
        
        # Parse XML
        root = ET.fromstring(xml_data)
        
        # Define namespace
        ns = {'atom': 'http://www.w3.org/2005/Atom',
              'arxiv': 'http://arxiv.org/schemas/atom'}
        
        # Find the entry
        entry = root.find('atom:entry', ns)
        if entry is None:
            return None
        
        result = {}
        
        # Get primary category
        primary_category = entry.find('arxiv:primary_category', ns)
        if primary_category is not None:
            result['category'] = primary_category.get('term')
        else:
            # Fallback: get first category if primary not found
            category_elem = entry.find('atom:category', ns)
            if category_elem is not None:
                result['category'] = category_elem.get('term')
        
        # Get comment (often contains publication info)
        comment_elem = entry.find('arxiv:comment', ns)
        if comment_elem is not None and comment_elem.text:
            result['comment'] = comment_elem.text.strip()
        
        # Get journal reference if available
        journal_ref = entry.find('arxiv:journal_ref', ns)
        if journal_ref is not None and journal_ref.text:
            result['journal_ref'] = journal_ref.text.strip()
        
        return result if result else None
    
    except Exception as e:
        # If API call fails, return None (will use default)
        print(f"Warning: Could not fetch arXiv metadata for {arxiv_id}: {e}", file=sys.stderr)
        return None


def format_entry(entry, fetch_categories=True, crossref_keys=None):
    """Format a BibTeX entry according to literatur.bib conventions.
    
    Args:
        entry: The BibTeX entry to format
        fetch_categories: Whether to fetch arXiv categories from API
        crossref_keys: Set of available crossref keys (e.g., {'iclr2022', 'aaai2023'})
    
    Returns:
        Tuple of (formatted_string, arxiv_metadata_dict or None)
    """
    # Check if this is an arXiv entry and convert it
    is_arxiv = is_arxiv_entry(entry)
    arxiv_id = None
    arxiv_metadata = None
    
    if is_arxiv:
        arxiv_id = extract_arxiv_id(entry)
        # Fetch metadata from arXiv API if requested
        if fetch_categories and arxiv_id:
            arxiv_metadata = fetch_arxiv_metadata(arxiv_id)
        # Convert to @Misc type
        entry_type = "Misc"
    else:
        # Capitalize entry type (e.g., @Misc, @Article, @InProceedings)
        entry_type = entry.typ.capitalize() if entry.typ.lower() in ['misc', 'book', 'phdthesis', 'mastersthesis'] else entry.typ.title()
    
    lines = [f"@{entry_type}{{{entry.key},"]
    
    # Check if we should suggest a crossref for conference papers
    suggested_crossref = None
    convert_to_inproceedings = False
    
    # Map common conference names to crossref patterns
    conf_patterns = {
        'international conference on learning representations': 'iclr',
        'iclr': 'iclr',
        'aaai': 'aaai',
        'international joint conference on artificial intelligence': 'ijcai',
        'ijcai': 'ijcai',
        'international conference on automated planning and scheduling': 'icaps',
        'icaps': 'icaps',
        'neural information processing systems': 'nips',
        'advances in neural information processing systems': 'nips',
        'nips': 'nips',
        'neurips': 'nips',
        'international conference on machine learning': 'icml',
        'icml': 'icml',
        'cvpr': 'cvpr',
        'iccv': 'iccv',
        'eccv': 'eccv',
        'annual meeting of the association for computational linguistics': 'acl',
        'acl': 'acl',
        'empirical methods in natural language processing': 'emnlp',
        'emnlp': 'emnlp',
        'naacl': 'naacl',
        'coling': 'coling',
    }
    
    year = entry.get("year", "")
    
    # Check booktitle field
    if crossref_keys and "booktitle" in entry and "crossref" not in entry:
        booktitle = str(entry["booktitle"]).lower()
        
        for pattern, crossref_prefix in conf_patterns.items():
            if pattern in booktitle:
                potential_crossref = f"{crossref_prefix}{year}"
                if potential_crossref in crossref_keys:
                    suggested_crossref = potential_crossref
                    break
    
    # Also check journal field for conferences incorrectly marked as journals
    if not suggested_crossref and crossref_keys and "journal" in entry and "crossref" not in entry:
        journal = str(entry["journal"]).lower()
        
        for pattern, crossref_prefix in conf_patterns.items():
            if pattern in journal:
                potential_crossref = f"{crossref_prefix}{year}"
                if potential_crossref in crossref_keys:
                    suggested_crossref = potential_crossref
                    convert_to_inproceedings = True
                    break
    
    # If we found a conference in journal field, convert to InProceedings
    if convert_to_inproceedings:
        entry_type = "Inproceedings"
    
    # Define field order based on literatur.bib conventions
    field_order = [
        "author", "editor", "title", "booktitle", "journal",
        "crossref", "series", "volume", "number", "pages",
        "publisher", "address", "school", "institution",
        "year", "howpublished", "note", "url", "doi"
    ]
    
    # Collect all fields to format
    formatted_fields = []
    
    # Fields to skip for arXiv entries (will be replaced with howpublished)
    arxiv_skip_fields = {"journal", "volume", "eprint", "archiveprefix", "primaryclass", "url"} if is_arxiv else set()
    
    # Fields to skip if we're suggesting a crossref
    if suggested_crossref:
        crossref_skip_fields = {"booktitle", "publisher", "year"}
        # Also skip journal and volume if we're converting from Article to InProceedings
        if convert_to_inproceedings:
            crossref_skip_fields.add("journal")
            crossref_skip_fields.add("volume")
    else:
        crossref_skip_fields = set()
    
    # Add fields in order, but skip certain fields for arXiv entries or crossref
    for field in field_order:
        if field in entry:
            # Skip fields that will be converted to howpublished for arXiv entries
            if field.lower() in arxiv_skip_fields:
                continue
            # Skip fields that are in the crossref
            if field.lower() in crossref_skip_fields:
                continue
            formatted_fields.append(format_field(field, entry[field]))
    
    # Add suggested crossref if we found one
    if suggested_crossref:
        formatted_fields.insert(
            len([f for f in formatted_fields if f.strip().startswith(("author", "editor", "title"))]),
            format_field("crossref", f'"{suggested_crossref}"')
        )
    
    # Add howpublished for arXiv entries if not already present
    if is_arxiv and arxiv_id and "howpublished" not in entry:
        # Use fetched category or default to cs.AI
        category = arxiv_metadata.get('category', 'cs.AI') if arxiv_metadata else 'cs.AI'
        howpublished_value = f'"arXiv:{arxiv_id} [{category}]"'
        formatted_fields.insert(
            len([f for f in formatted_fields if not f.strip().startswith(("note", "doi"))]),
            format_field("howpublished", howpublished_value)
        )
    
    # Add any remaining fields not in the standard order
    for field, value in entry.items():
        if field not in field_order and field != "crossref-for-tests":
            # Skip arXiv-specific fields
            if field.lower() in arxiv_skip_fields:
                continue
            formatted_fields.append(format_field(field, value))
    
    # Add commas to all fields except the last one
    for i, field_line in enumerate(formatted_fields):
        if i < len(formatted_fields) - 1:
            lines.append(field_line + ",")
        else:
            lines.append(field_line)
    
    lines.append("}")
    return "\n".join(lines), arxiv_metadata


def suggest_key(entry, original_text=None):
    """Suggest a key following literatur.bib naming conventions.
    
    Args:
        entry: The parsed BibTeX entry
        original_text: Optional original text of the entry to extract macro names
    """
    # Extract author surnames
    if "author" not in entry:
        author_part = "unknown"
    else:
        authors = entry.authors()
        if len(authors) == 1:
            # Single author: use surname
            last_name = authors[0].last
            if callable(last_name):
                last_name = last_name()
            if isinstance(last_name, list):
                author_part = strip_latex_accents(last_name[0]).lower()
            else:
                author_part = strip_latex_accents(str(last_name)).lower()
        elif len(authors) == 2:
            # Two authors: surname1-surname2
            last1 = authors[0].last
            last2 = authors[1].last
            if callable(last1):
                last1 = last1()
            if callable(last2):
                last2 = last2()
            if isinstance(last1, list):
                last1 = last1[0]
            if isinstance(last2, list):
                last2 = last2[0]
            author_part = f"{strip_latex_accents(str(last1)).lower()}-{strip_latex_accents(str(last2)).lower()}"
        else:
            # Three or more: firstauthor-et-al
            last_name = authors[0].last
            if callable(last_name):
                last_name = last_name()
            if isinstance(last_name, list):
                last_name = last_name[0]
            author_part = f"{strip_latex_accents(str(last_name)).lower()}-et-al"
    
    # Extract venue
    venue_part = ""
    year = entry.get("year", "")
    
    # Check if this is an arXiv entry (either @Misc with howpublished or @article with arxiv journal)
    if is_arxiv_entry(entry):
        venue_part = f"arxiv{year}"
    # Determine venue based on entry type and fields
    elif entry.typ.lower() == "book":
        venue_part = year
    elif "crossref" in entry:
        # Extract venue from crossref (e.g., "icaps2024" from crossref)
        crossref = entry["crossref"]
        # Remove quotes if present
        crossref = crossref.strip('"')
        venue_part = crossref
    elif "booktitle" in entry or "journal" in entry:
        # Try to extract conference name from booktitle or journal (for misclassified conferences)
        text_to_check = ""
        if "booktitle" in entry:
            text_to_check = str(entry["booktitle"]).lower()
        elif "journal" in entry:
            text_to_check = str(entry["journal"]).lower()
        
        # Map conference patterns to venue abbreviations (same as in format_entry)
        conf_patterns = {
            'international conference on learning representations': 'iclr',
            'iclr': 'iclr',
            'aaai': 'aaai',
            'international joint conference on artificial intelligence': 'ijcai',
            'ijcai': 'ijcai',
            'international conference on automated planning and scheduling': 'icaps',
            'icaps': 'icaps',
            'neural information processing systems': 'nips',
            'advances in neural information processing systems': 'nips',
            'nips': 'nips',
            'neurips': 'nips',
            'international conference on machine learning': 'icml',
            'icml': 'icml',
            'cvpr': 'cvpr',
            'iccv': 'iccv',
            'eccv': 'eccv',
            'annual meeting of the association for computational linguistics': 'acl',
            'acl': 'acl',
            'empirical methods in natural language processing': 'emnlp',
            'emnlp': 'emnlp',
            'naacl': 'naacl',
            'coling': 'coling',
        }
        
        venue_found = False
        for pattern, venue_abbr in conf_patterns.items():
            if pattern in text_to_check:
                venue_part = f"{venue_abbr}{year}"
                venue_found = True
                break
        
        if not venue_found:
            # If no conference pattern matched and it's a journal, try to extract macro
            if "journal" in entry:
                journal_macro = None
                if original_text:
                    # Look for journal = macro_name (without quotes)
                    match = re.search(r'journal\s*=\s*([a-z]+)\s*[,}]', original_text, re.IGNORECASE)
                    if match:
                        potential_macro = match.group(1).lower()
                        # Known journal macros from abbrv.bib
                        known_journals = [
                            'jair', 'aij', 'aimag', 'jmlr', 'jacm', 'sicomp', 'tcs',
                            'amai', 'compint', 'ieeecomp', 'jcss', 'ker', 'nmi', 'jml',
                            'ejor', 'iandc', 'jlogprog', 'sttt', 'lncs', 'lnai',
                            'nature', 'symmetry', 'ieeecomm', 'ieeenn'
                        ]
                        if potential_macro in known_journals:
                            journal_macro = potential_macro
                
                if journal_macro:
                    venue_part = f"{journal_macro}{year}"
                else:
                    venue_part = year
            else:
                venue_part = year
    elif entry.typ.lower() == "phdthesis":
        venue_part = year
    elif entry.typ.lower() == "mastersthesis":
        venue_part = year
    else:
        venue_part = year
    
    suggested_key = f"{author_part}-{venue_part}"
    
    # Clean up the key
    suggested_key = suggested_key.replace(" ", "").replace("_", "-")
    
    return suggested_key


def check_key_conventions(entry, suggested_key=None):
    """Check if entry key follows naming conventions and return warnings."""
    warnings = []
    key = entry.key
    
    if suggested_key and key != suggested_key:
        warnings.append(f"  SUGGESTED KEY: {suggested_key}")
    
    # Check for year in key
    year_match = re.search(r'\d{4}', key)
    if not year_match:
        warnings.append(f"  WARNING: Key should contain a 4-digit year")
    elif "year" in entry and int(year_match.group()) != int(entry["year"]):
        warnings.append(f"  WARNING: Year in key ({year_match.group()}) doesn't match year field ({entry['year']})")
    
    # Check author naming convention
    if "author" in entry:
        num_authors = len(entry.authors())
        if num_authors >= 3 and "-et-al-" not in key:
            warnings.append(f"  WARNING: Use -et-al- in key for {num_authors} authors")
        elif num_authors < 3 and "-et-al-" in key:
            warnings.append(f"  WARNING: Don't use -et-al- for {num_authors} author(s)")
    
    # Check for tabs
    entry_str = str(entry)
    if '\t' in entry_str:
        warnings.append(f"  WARNING: Entry contains tabs (should use spaces)")
    
    return warnings


def main():
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "folder",
        help="Folder containing .bib files to compare with literatur.bib"
    )
    parser.add_argument(
        "--literatur",
        default="literatur.bib",
        help="Path to literatur.bib file (default: literatur.bib)"
    )
    parser.add_argument(
        "--output",
        help="Output file for suggestions (default: print to stdout)"
    )
    parser.add_argument(
        "--show-warnings",
        action="store_true",
        help="Show warnings about key naming conventions"
    )
    parser.add_argument(
        "--exclude",
        action="append",
        default=[],
        help="Exclude files matching this pattern (can be used multiple times)"
    )
    parser.add_argument(
        "--fetch-arxiv-categories",
        action="store_true",
        default=True,
        help="Fetch arXiv categories from arXiv API (default: enabled)"
    )
    parser.add_argument(
        "--no-fetch-arxiv-categories",
        dest="fetch_arxiv_categories",
        action="store_false",
        help="Don't fetch arXiv categories, use default [cs.AI]"
    )
    
    args = parser.parse_args()
    
    # Add default exclusions for common auxiliary files
    default_exclusions = ['abbrv.bib', 'abbrv-short.bib', 'crossref.bib', 'crossref-short.bib']
    if not args.exclude:
        args.exclude = default_exclusions
    else:
        # Combine user exclusions with defaults
        args.exclude.extend(default_exclusions)
    
    # Check if literatur.bib exists
    if not os.path.exists(args.literatur):
        print(f"Error: {args.literatur} not found", file=sys.stderr)
        sys.exit(1)
    
    # Check if folder exists
    if not os.path.isdir(args.folder):
        print(f"Error: {args.folder} is not a directory", file=sys.stderr)
        sys.exit(1)
    
    # Find all .bib files in the folder
    folder_path = Path(args.folder)
    all_bib_files = list(folder_path.glob("*.bib"))
    
    # Filter out excluded files
    bib_files = []
    excluded_files = []
    for bib_file in all_bib_files:
        if bib_file.name in args.exclude:
            excluded_files.append(bib_file.name)
        else:
            bib_files.append(bib_file)
    
    if excluded_files:
        print(f"Excluding files: {', '.join(excluded_files)}", file=sys.stderr)
    
    if not bib_files:
        print(f"No .bib files found in {args.folder} (after exclusions)", file=sys.stderr)
        sys.exit(1)
    
    print(f"Found {len(bib_files)} .bib file(s) to process in {args.folder}", file=sys.stderr)
    
    # Parse literatur.bib
    print(f"Parsing {args.literatur}...", file=sys.stderr)
    with open(args.literatur, 'r') as f:
        literatur_db = parse_bib_files([f])
    literatur_keys = set(literatur_db.keys())
    print(f"Found {len(literatur_keys)} entries in {args.literatur}", file=sys.stderr)
    
    # Parse crossref.bib to get available conference crossrefs
    crossref_keys = set()
    crossref_path = Path(args.literatur).parent / "crossref.bib"
    if crossref_path.exists():
        print(f"Loading crossref entries from {crossref_path}...", file=sys.stderr)
        try:
            with open(crossref_path, 'r') as f:
                crossref_db = parse_bib_files([f])
            crossref_keys = set(crossref_db.keys())
            print(f"Found {len(crossref_keys)} crossref entries", file=sys.stderr)
        except Exception as e:
            print(f"Warning: Could not load crossref.bib: {e}", file=sys.stderr)
    
    # Build maps for duplicate detection
    # This helps detect duplicates even if keys are different
    print(f"Building duplicate detection maps...", file=sys.stderr)
    literatur_suggested_keys = {}
    literatur_titles = {}
    for lit_key, lit_entry in literatur_db.items():
        suggested = suggest_key(lit_entry, original_text=None)
        literatur_suggested_keys[suggested] = lit_key
        
        # Also map normalized titles for duplicate detection
        if "title" in lit_entry:
            # Normalize title: lowercase, remove punctuation, extra spaces
            title = str(lit_entry["title"]).lower()
            title = re.sub(r'[{}"\']', '', title)  # Remove braces, quotes
            title = re.sub(r'[^\w\s]', ' ', title)  # Replace punctuation with space
            title = re.sub(r'\s+', ' ', title).strip()  # Normalize whitespace
            literatur_titles[title] = lit_key
    
    # Parse files from the folder
    print(f"Parsing files from {args.folder}...", file=sys.stderr)
    with open(bib_files[0], 'r') as f:
        folder_files = [f] + [open(bf, 'r') for bf in bib_files[1:]]
        folder_db = parse_bib_files(folder_files)
        for f in folder_files[1:]:
            f.close()
    
    print(f"Found {len(folder_db)} entries in folder files", file=sys.stderr)
    
    # Find new entries and store with original text and suggested keys
    new_entries = []
    key_mappings = []  # For sed script: (old_key, new_key)
    duplicates_found = []  # Track duplicates for reporting
    
    # Track suggested keys within new entries to handle collisions
    new_entry_keys = {}  # Maps base suggested key to count
    
    for key, entry in folder_db.items():
        # Get original text first so we can extract journal macros
        original_text = get_original_entry_text(entry, bib_files)
        suggested_key = suggest_key(entry, original_text=original_text)
        
        # Check for duplicates by key, suggested key, and title
        if key in literatur_keys:
            # Exact key match - skip silently
            continue
        elif suggested_key in literatur_suggested_keys:
            # Duplicate detected by suggested key
            existing_key = literatur_suggested_keys[suggested_key]
            duplicates_found.append((key, suggested_key, existing_key))
            continue
        
        # Check for duplicate by title
        if "title" in entry:
            title = str(entry["title"]).lower()
            title = re.sub(r'[{}"\']', '', title)  # Remove braces, quotes
            title = re.sub(r'[^\w\s]', ' ', title)  # Replace punctuation with space
            title = re.sub(r'\s+', ' ', title).strip()  # Normalize whitespace
            
            if title in literatur_titles:
                existing_key = literatur_titles[title]
                duplicates_found.append((key, f"title match", existing_key))
                continue
        
        # Check for collision with other new entries
        base_key = suggested_key
        if suggested_key in new_entry_keys:
            # Collision detected - append letter suffix (a, b, c, ...)
            count = new_entry_keys[suggested_key]
            suffix = chr(ord('a') + count)
            suggested_key = f"{base_key}{suffix}"
            new_entry_keys[base_key] = count + 1
        else:
            # First occurrence of this key
            new_entry_keys[suggested_key] = 1
        
        # This is a new entry
        new_entries.append((entry, original_text, suggested_key))
        if key != suggested_key:
            key_mappings.append((key, suggested_key))
    
    # Report duplicates
    if duplicates_found:
        print(f"\nFound {len(duplicates_found)} duplicate(s) (already in literatur.bib with different keys):", file=sys.stderr)
        for orig_key, sugg_key, existing_key in duplicates_found:
            print(f"  - {orig_key} -> would be {sugg_key}, but already exists as {existing_key}", file=sys.stderr)
    
    if not new_entries:
        print("\nNo new entries found. All entries already exist in literatur.bib.", file=sys.stderr)
        return
    
    print(f"\nFound {len(new_entries)} new entries not in {args.literatur}", file=sys.stderr)
    
    # Sort entries by suggested key
    new_entries.sort(key=lambda x: x[2])
    
    # Format output
    output_lines = [
        "# Suggested additions to literatur.bib",
        f"# Found {len(new_entries)} new entries",
        "#",
        "# Each entry is shown in two forms:",
        "# 1. ORIGINAL: The entry as it appears in the source file",
        "# 2. FORMATTED: The entry formatted according to literatur.bib conventions",
        "#    with suggested key following naming conventions",
        "#",
        "# Please review these entries and add them to literatur.bib if appropriate.",
        "# Make sure to:",
        "# - Verify the key follows naming conventions",
        "# - Check that all fields are correct",
    ]
    
    if args.fetch_arxiv_categories:
        output_lines.append("# - For arXiv entries: categories are fetched from arXiv API")
    else:
        output_lines.append("# - For arXiv entries: verify the category (e.g., [cs.AI], [cs.CL], [cs.LG])")
        output_lines.append("#   The script uses [cs.AI] as default; check the actual arXiv page for the correct category")
    
    output_lines.extend([
        "# - Add crossref if applicable",
        "# - Maintain alphabetical order by key",
        "",
    ])
    
    # Separate lists for arXiv and non-arXiv entries
    arxiv_entries = []
    non_arxiv_entries = []
    
    for entry, original_text, suggested_key in new_entries:
        # Add original form
        output_lines.append("# " + "="*76)
        output_lines.append(f"# ORIGINAL form of entry: {entry.key}")
        if entry.key != suggested_key:
            output_lines.append(f"# SUGGESTED KEY: {suggested_key}")
        output_lines.append("# " + "="*76)
        if original_text:
            for line in original_text.split('\n'):
                output_lines.append(f"# {line}")
        else:
            output_lines.append("# (Original text not found)")
        output_lines.append("")
        
        # Add formatted form with suggested key
        output_lines.append("# " + "-"*76)
        output_lines.append(f"# FORMATTED form (ready to add to literatur.bib):")
        
        # Temporarily change the key to the suggested one for formatting
        original_key = entry.key
        entry.key = suggested_key
        formatted, arxiv_meta = format_entry(entry, fetch_categories=args.fetch_arxiv_categories, crossref_keys=crossref_keys)
        entry.key = original_key  # Restore original key
        
        # Check if this is an arXiv entry
        is_arxiv = is_arxiv_entry(entry)
        
        # Add arXiv metadata as comments if available
        if is_arxiv:
            if arxiv_meta:
                if 'journal_ref' in arxiv_meta:
                    output_lines.append(f"# arXiv journal reference: {arxiv_meta['journal_ref']}")
                if 'comment' in arxiv_meta:
                    output_lines.append(f"# arXiv comment: {arxiv_meta['comment']}")
            else:
                # No metadata fetched - using default category
                output_lines.append(f"# NOTE: Using default category [cs.AI] (arXiv API unavailable)")
                output_lines.append(f"# Please verify the correct category at https://arxiv.org/abs/{extract_arxiv_id(entry)}")
        
        output_lines.append("# " + "-"*76)
        output_lines.append(formatted)
        
        # Store formatted entry for separate files
        if is_arxiv:
            arxiv_entries.append(formatted)
        else:
            non_arxiv_entries.append(formatted)
        
        if args.show_warnings:
            warnings = check_key_conventions(entry, suggested_key)
            if warnings:
                output_lines.append("")
                for warning in warnings:
                    output_lines.append(warning)
        
        output_lines.append("")  # Empty line between entries
    
    # Write or print output
    output_text = "\n".join(output_lines)
    
    if args.output:
        with open(args.output, 'w') as f:
            f.write(output_text)
        print(f"\nSuggestions written to {args.output}", file=sys.stderr)
        
        # Write separate files for arXiv and non-arXiv entries
        if arxiv_entries:
            arxiv_file = args.output.replace('.txt', '_arxiv.bib')
            with open(arxiv_file, 'w') as f:
                f.write("% arXiv entries\n")
                f.write("% Add these to literatur.bib in alphabetical order\n\n")
                f.write("\n\n".join(arxiv_entries))
                f.write("\n")
            print(f"arXiv entries written to {arxiv_file}", file=sys.stderr)
        
        if non_arxiv_entries:
            non_arxiv_file = args.output.replace('.txt', '_other.bib')
            with open(non_arxiv_file, 'w') as f:
                f.write("% Non-arXiv entries\n")
                f.write("% Add these to literatur.bib in alphabetical order\n\n")
                f.write("\n\n".join(non_arxiv_entries))
                f.write("\n")
            print(f"Non-arXiv entries written to {non_arxiv_file}", file=sys.stderr)
        
        # Write diff file with original entries (as they appear in source)
        diff_file = args.output.replace('.txt', '_diff.bib')
        with open(diff_file, 'w') as f:
            f.write("% Original entries from source (not in literatur.bib)\n")
            f.write("% These are the raw entries as they appear in the source files\n\n")
            for entry, original_text, suggested_key in new_entries:
                if original_text:
                    f.write(original_text)
                    f.write("\n\n")
                else:
                    # Fallback if original text not found
                    f.write(f"% Original text not found for {entry.key}\n\n")
        print(f"Original entries (diff) written to {diff_file}", file=sys.stderr)
        
        # Generate sed script for key replacements
        if key_mappings:
            sed_script_path = args.output.replace('.txt', '_replace_keys.sed')
            with open(sed_script_path, 'w') as f:
                f.write("#!/usr/bin/sed -f\n")
                f.write("#\n")
                f.write("# Sed script to replace BibTeX keys in .tex files\n")
                f.write(f"# Generated for {len(key_mappings)} key changes\n")
                f.write("#\n")
                f.write("# Usage: sed -f this_script.sed your_file.tex > output.tex\n")
                f.write("#    or: sed -i.bak -f this_script.sed your_file.tex\n")
                f.write("#\n\n")
                
                for old_key, new_key in sorted(key_mappings):
                    # Replace in \cite{}, \citep{}, \citet{}, etc.
                    f.write(f"# {old_key} -> {new_key}\n")
                    f.write(f"s/\\\\cite\\({{[^}}]*\\)\\b{re.escape(old_key)}\\b/\\\\cite\\1{new_key}/g\n")
                    f.write(f"s/\\\\cite\\[{{[^}}]*\\]\\({{[^}}]*\\)\\b{re.escape(old_key)}\\b/\\\\cite[\\1]\\2{new_key}/g\n")
                    f.write("\n")
            
            print(f"Sed script for key replacements written to {sed_script_path}", file=sys.stderr)
            print(f"Usage: sed -i.bak -f {sed_script_path} your_file.tex", file=sys.stderr)
    else:
        print("\n" + "="*80, file=sys.stderr)
        print(output_text)
        
        # Print sed commands to stderr if there are key mappings
        if key_mappings:
            print("\n" + "="*80, file=sys.stderr)
            print("# Sed commands to replace keys in .tex files:", file=sys.stderr)
            print("# (Save these to a .sed file or run directly)", file=sys.stderr)
            print("="*80, file=sys.stderr)
            for old_key, new_key in sorted(key_mappings):
                print(f"# {old_key} -> {new_key}", file=sys.stderr)
                print(f"s/\\\\cite\\({{[^}}]*\\)\\b{re.escape(old_key)}\\b/\\\\cite\\1{new_key}/g", file=sys.stderr)


if __name__ == "__main__":
    main()

# Made with Bob
