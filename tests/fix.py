#! /usr/bin/env python

"""Fix BibTeX entries."""

import argparse
import re


BIBTYPES = [
    "Article", "Book", "InCollection", "InProceedings", "MastersThesis",
    "Misc", "PhdThesis", "Proceedings", "TechReport", "Unpublished",
]


def fix_bibtex(input_file: str, output_file: str):
    with open(input_file, "r") as f:
        content = f.read()

    # Fix capitalization of BibTeX entry types.
    for typ in BIBTYPES:
        content = re.sub("@" + typ + "\\{", "@" + typ + "{", content, flags=re.IGNORECASE)

    with open(output_file, "w") as f:
        f.write(content)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input', help='Input BibTeX file')
    parser.add_argument('output', help='Output BibTeX file')

    args = parser.parse_args()
    fix_bibtex(args.input, args.output)
