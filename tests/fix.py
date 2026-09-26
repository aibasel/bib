#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.8"
# dependencies = []
# ///

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
    "doi",
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

    errors = []
    for i, line in enumerate(content.splitlines(), start=1):
        if re.search(r"TODO(?!\([^()]+\))", line):
            errors.append(f"[error] TODOs need the form \"TODO(John)\" (line {i}): {line}")

        try:
            line.encode('ascii')
        except UnicodeEncodeError:
            errors.append(f"[error] non-ASCII character in line {i}: {line}")


    # Fix capitalization of BibTeX entry types.
    for typ in BIBTYPES:
        content = re.sub("@" + typ + "\\{", "@" + typ + "{", content, flags=re.IGNORECASE)

    # Fix whitespace.
    for field in FIELDS:
        content = re.sub(r"^\s*" + field + r"\s*=\s*(\S+)", f"  {field} = {' ' * (12 - len(field))}\\g<1>", content, flags=re.IGNORECASE | re.MULTILINE)

    for field in FIELDS:
        for line in re.findall(r"^\s*" + field + r"\s*=\s*\{.*?$", content, flags=re.IGNORECASE | re.MULTILINE):
            errors.append(f"[error] use quotation marks instead of curly braces: {line}")

    if errors:
        raise SystemExit("\n".join(errors))

    with open(output_file, "w") as f:
        f.write(content)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input', help='Input BibTeX file')
    parser.add_argument('output', help='Output BibTeX file')

    args = parser.parse_args()
    fix_bibtex(args.input, args.output)
