# Suggest Additions Tool

## Overview

`suggest_additions.py` is a Python script that helps you clean up and merge BibTeX files from other sources into `literatur.bib`. It compares entries from a folder of `.bib` files with your main `literatur.bib` file and suggests new entries that don't already exist, formatted according to the conventions specified at the top of `literatur.bib`.

## Features

- **Automatic comparison**: Identifies entries in external `.bib` files that aren't in `literatur.bib`
- **Smart duplicate detection**: Compares entries by suggested keys (author+venue+year), not just existing keys
  - Catches duplicates even if they have different keys in source files
  - Reports duplicates with their existing keys in literatur.bib
- **Side-by-side comparison**: Shows both the original entry and the formatted version for each suggestion
- **Format compliance**: Formats suggestions according to `literatur.bib` conventions:
  - Fields aligned at column 18
  - Double quotes instead of curly braces for field values
  - Proper spacing and indentation
  - Sorted by key
- **arXiv detection and API integration**: Automatically detects and converts arXiv entries:
  - Converts `@article` entries with "arXiv preprint" in journal field to `@Misc`
  - **Fetches correct category from arXiv API** (e.g., `[cs.CL]`, `[cs.AI]`, `[cs.LG]`)
  - Extracts arXiv ID and formats as `howpublished = "arXiv:ID [category]"`
  - Suggests key format: `author-et-al-arxiv2023`
  - Fallback to `[cs.AI]` if API call fails or is disabled
- **Key validation**: Optional warnings about key naming conventions (author names, year format, etc.)
- **Multiple file support**: Processes all `.bib` files in a specified folder

## Installation

Make sure you have the required dependencies installed:

```bash
# Activate your virtual environment
source .venv/bin/activate

# Dependencies are already in requirements.txt
pip install -r requirements.txt
```

## Usage

### Basic Usage

Compare `.bib` files in a folder with `literatur.bib`:

```bash
./tests/suggest_additions.py /path/to/other/bib/files/
```

This will print suggested additions to stdout.

### Save to File

Save suggestions to a file for review:

```bash
./tests/suggest_additions.py /path/to/other/bib/files/ --output suggestions.txt
```

This creates three files:
- `suggestions.txt` - Full report with original and formatted entries
- `suggestions_arxiv.bib` - Only arXiv entries, ready to copy to literatur.bib
- `suggestions_other.bib` - Only non-arXiv entries, ready to copy to literatur.bib

### Show Warnings

Get warnings about key naming conventions:

```bash
./tests/suggest_additions.py /path/to/other/bib/files/ --show-warnings
```

### Disable arXiv API

By default, the script fetches arXiv categories from the arXiv API. To disable this and use the default `[cs.AI]`:

```bash
./tests/suggest_additions.py /path/to/other/bib/files/ --no-fetch-arxiv-categories
```

### Custom literatur.bib Location

If your `literatur.bib` is not in the current directory:

```bash
./tests/suggest_additions.py /path/to/other/bib/files/ --literatur /path/to/literatur.bib
```

## Command-Line Options

- `folder` (required): Path to folder containing `.bib` files to compare
- `--literatur PATH`: Path to literatur.bib file (default: `literatur.bib`)
- `--output FILE`: Save suggestions to a file instead of printing to stdout
- `--show-warnings`: Display warnings about key naming conventions
- `--fetch-arxiv-categories`: Fetch arXiv categories from arXiv API (default: enabled)
- `--no-fetch-arxiv-categories`: Don't fetch arXiv categories, use default `[cs.AI]`
- `--exclude PATTERN`: Exclude files matching this pattern (can be used multiple times)

## Example Workflow

1. **Collect external `.bib` files**: Place all `.bib` files you want to merge into a folder, e.g., `~/Downloads/papers/`

2. **Generate suggestions**:
   ```bash
   ./tests/suggest_additions.py ~/Downloads/papers/ --output suggestions.txt --show-warnings
   ```

3. **Review suggestions**: Open `suggestions.txt` and review the suggested entries

4. **Add to literatur.bib**: Copy appropriate entries from `suggestions.txt` to `literatur.bib`, making any necessary adjustments:
   - Verify keys follow naming conventions
   - Add crossref entries if applicable
   - Check for duplicate content with different keys
   - Ensure proper alphabetical ordering

5. **Validate**: Run the existing tests to ensure everything is correct:
   ```bash
   ./tests/run-tests.sh
   ```

## Key Naming Conventions

The script checks for these conventions (from `literatur.bib` header):

- **Authors**: 
  - 1-2 authors: use both surnames (e.g., `russell-norvig-2003`)
  - 3+ authors: use first author + `-et-al-` (e.g., `pommerening-et-al-icaps2014`)
  
- **Venue**:
  - Books: year only (e.g., `russell-norvig-2003`)
  - Conference papers: conference + year (e.g., `jonas-icaps2012`)
  - Workshop papers: conference + year + `ws` (e.g., `jonas-nips2011ws`)
  - arXiv: use `arxiv` + year (e.g., `achiam-et-al-arxiv2023`)

- **Year**: Must include 4-digit year matching the year field

## Output Format

The script generates output with:
- Header comments explaining the suggestions
- For each new entry, two versions are shown:
  1. **ORIGINAL**: The entry as it appears in the source file
  2. **FORMATTED**: The entry formatted according to `literatur.bib` conventions
- Optional warnings about key naming issues
- Empty lines between entries

Example output:
```
# Suggested additions to literatur.bib
# Found 2 new entries
#
# Each entry is shown in two forms:
# 1. ORIGINAL: The entry as it appears in the source file
# 2. FORMATTED: The entry formatted according to literatur.bib conventions

# ============================================================================
# ORIGINAL form of entry: smith-jones-jair2023
# ============================================================================
# @article{smith-jones-jair2023,
#   author={John Smith and Jane Jones},
#   title={A Novel Approach to AI Planning},
#   journal={Journal of Artificial Intelligence Research},
#   volume={76},
#   pages={123-145},
#   year={2023}
# }

# ----------------------------------------------------------------------------
# FORMATTED form (ready to add to literatur.bib):
# ----------------------------------------------------------------------------
@Article{smith-jones-jair2023,
  author =       "John Smith and Jane Jones",
  title =        "A Novel Approach to {AI} Planning",
  journal =      "Journal of Artificial Intelligence Research",
  volume =       "76",
  pages =        "123--145",
  year =         "2023"
}

```

This side-by-side comparison makes it easy to:
- See what changes were made during formatting
- Verify that no information was lost
- Understand the formatting conventions being applied

## arXiv Entry Handling

The script automatically detects and converts arXiv entries to the proper format:

**Input formats detected:**
- `@article` with journal field like `"arXiv preprint arXiv:2303.08774"`
- `@article` with `journal = "ArXiv"` or `journal = "CoRR"` and `volume = "abs/2401.05319"`
- `@Misc` with howpublished field containing `"arXiv:..."`
- `@misc` with `eprint`, `archivePrefix`, and `primaryClass` fields (common export format)

**Output format (all variants converted to):**
```
# FORMATTED form (ready to add to literatur.bib):
# arXiv comment: 92 pages, 53 figures, 20 tables
# ----------------------------------------------------------------------------
@Misc{dubey-et-al-arxiv2024,
  author =      "Abhimanyu Dubey and ...",
  title =       "The Llama 3 Herd of Models",
  year =        "2024",
  howpublished = "arXiv:2407.21783 [cs.AI]"
}
```

**Conversion details:**
- Removes `eprint`, `archivePrefix`, `primaryClass`, and `url` fields
- Consolidates information into a single `howpublished` field
- Format: `arXiv:ID [category]`
- **Includes arXiv metadata as comments**: journal reference (if published) and comments
- Helps identify if a published version exists

**arXiv API Integration:**
- **By default**, the script fetches the correct category from the arXiv API
- For example, GPT-4 paper (arXiv:2303.08774) is correctly categorized as `[cs.CL]`
- Llama 3 paper (arXiv:2407.21783) is correctly categorized as `[cs.AI]`
- The API call is made once per arXiv entry during processing
- If the API call fails (network issues, rate limiting), it falls back to `[cs.AI]`
- Use `--no-fetch-arxiv-categories` to disable API calls and always use `[cs.AI]`

**Key format:**
- The suggested key format is: `firstauthor-et-al-arxiv2024`
- Common categories you might see: `[cs.AI]`, `[cs.CL]`, `[cs.LG]`, `[cs.CV]`, `[cs.RO]`, etc.

## Duplicate Detection

The script uses smart duplicate detection to avoid suggesting entries that already exist:

1. **Exact key matching**: Skips entries with keys that already exist in literatur.bib
2. **Suggested key matching**: Compares entries by their suggested keys (based on author+venue+year)
   - Example: If you import an entry with key `wrong-key-ai-book` but it would be suggested as `russell-norvig-2003`, and `russell-norvig-2003` already exists in literatur.bib, it will be detected as a duplicate
3. **Duplicate reporting**: Duplicates are reported to stderr with both the original key and the existing key

**Example output:**
```
Found 1 duplicate(s) (already in literatur.bib with different keys):
  - wrong-key-ai-book -> would be russell-norvig-2003, but already exists as russell-norvig-2003
```

This helps you identify entries that are already in your bibliography but might have inconsistent keys in different source files.

## Notes

- The script uses the `biblib` library (same as other test scripts) for parsing
- Non-ASCII characters will cause errors (as per `literatur.bib` conventions)
- The script does not modify any files automatically; it only suggests additions
- Always review suggestions before adding them to `literatur.bib`