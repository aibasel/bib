#! /usr/bin/env python

"""Fix BibTeX entries."""

import argparse
import re


BIBTYPES = [
    "Article", "Book", "InCollection", "InProceedings", "MastersThesis",
    "Misc", "PhdThesis", "Proceedings", "TechReport", "Unpublished",
]

FIELDS = [
    "address",
    "author",
    "booktitle",
    "crossref",
    "editor",
    "institution",
    "journal",
    "number",
    "pages",
    "publisher",
    "school",
    "series",
    "title",
    "volume",
    "year",
]


def fix_bibtex(input_file: str, output_file: str):
    with open(input_file, "r") as f:
        content = f.read()

    for i, line in enumerate(content.splitlines(), start=1):
        try:
            line.encode('ascii')
        except UnicodeEncodeError:
            raise SystemExit(f"[error] non-ASCII character in line {i}: {line}")    

    # Fix capitalization of BibTeX entry types.
    for typ in BIBTYPES:
        content = re.sub("@" + typ + "\\{", "@" + typ + "{", content, flags=re.IGNORECASE)

    # Fix whitespace.
    for field in FIELDS:
        content = re.sub(r"^\s*" + field + r"\s*=\s*(\S+)", f"  {field} = {' ' * (12 - len(field))}\\g<1>", content, flags=re.IGNORECASE | re.MULTILINE)

    for field in FIELDS:
        for line in re.findall(r"^\s*" + field + r"\s*=\s*\{.*?$", content, flags=re.IGNORECASE | re.MULTILINE):
            raise SystemExit(f"[error] use quotation marks instead of curly braces: {line}")

    with open(output_file, "w") as f:
        f.write(content)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input', help='Input BibTeX file')
    parser.add_argument('output', help='Output BibTeX file')

    args = parser.parse_args()
    fix_bibtex(args.input, args.output)
