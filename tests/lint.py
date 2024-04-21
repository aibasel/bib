#!/usr/bin/env python3

"""Run some checks on .bib database(s)."""

import argparse
import re
import sys

import biblib.bib


def main():
    arg_parser = argparse.ArgumentParser(description=__doc__)
    arg_parser.add_argument("bib", nargs="+", help=".bib file(s) to process", type=open)
    args = arg_parser.parse_args()

    try:
        db = biblib.bib.Parser().parse(args.bib, log_fp=sys.stderr).get_entries()
    except biblib.messages.InputError:
        sys.exit(1)

    db = biblib.bib.resolve_crossrefs(db, min_crossrefs=999)

    types = {entry.typ for entry in db.values()}
    print(f"Found {len(db)} entries of types: {types}")

    num_errors = 0
    for entry in db.values():

        def print_error(msg, field):
            nonlocal num_errors
            print(f"[{entry.key}] {msg}: {field}")
            num_errors += 1

        if entry.typ != "proceedings":
            if ("author" in entry and "," in entry["author"] and
                not any(x in entry["author"] for x in ["Jr.", "II", "III", "IV"])):
                print_error("remove commas from author field", entry["author"])

            year_in_key = re.search(r"\d{4}", entry.key)
            if not year_in_key:
                print_error("add four-digit year to bibkey", entry.key)
            elif "year" not in entry:
                print_error("add year field", entry.key)
            elif int(year_in_key.group()) != int(entry["year"]):
                print_error("year in bibkey does not match year field", entry['year'])

            pages = entry.get("pages")
            if pages and "-" in pages and not "--" in pages:
                print_error("replace hyphen in pages field with double hyphen", entry["pages"])

            if re.match(r"[^\{]*\b[A-Z]{2,}\b[^\}]*", entry.get("title", "")):
                print_error("escape uppercase acronym in title field with curly braces", entry["title"])

    if num_errors:
        sys.exit(f"Found {num_errors} errors.")
    else:
        print("No errors found.")


if __name__ == "__main__":
    main()
