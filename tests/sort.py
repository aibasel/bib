#! /usr/bin/env python

""""Order BibTeX entries by bibkey."""

import argparse
import operator
import re


def extract_key_comment_entry(bibtext: str):
    """
    Split the BibTeX entries and their corresponding comments.
    """
    bib_entry_pattern = r"(@[a-zA-Z]+\{[^@]+\n\s*\}\n?)"
    entries = re.split(bib_entry_pattern, bibtext)

    keys = []
    comments = []
    bibentries = []
    for entry in entries:
        if entry.startswith("@"):
            keys.append(entry.split('{', 1)[1].split(',', 1)[0])
            bibentries.append(entry)
        else:
            comments.append(entry)

    # Remove the string after the last BibTeX entry.
    suffix = comments.pop()
    assert not suffix.strip(), suffix

    assert len(keys) == len(comments) == len(bibentries), (len(keys), len(comments), len(bibentries))
    return dict(zip(keys, zip(comments, bibentries)))


def reorder_bibtex(input_file: str, output_file: str):
    """
    Read a BibTeX file, reorder the BibTeX entries by their keys and write to a
    new file.
    """
    with open(input_file, "r") as f:
        content = f.read()

    entries_dict = extract_key_comment_entry(content)
    print(f"Found {len(entries_dict)} entries.")
    sorted_entries = dict(sorted(entries_dict.items(), key=operator.itemgetter(0)))

    with open(output_file, "w") as f:
        for key, (comment, entry) in sorted_entries.items():
            if comment.strip():
                f.write(f"{comment.strip()}\n")
            f.write(f"{entry}\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input', help='Input BibTeX file')
    parser.add_argument('output', help='Output BibTeX file')

    args = parser.parse_args()
    reorder_bibtex(args.input, args.output)
