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

    # Resolving crossrefs deletes the "crossref" field, so we duplicate it for the tests.
    for entry in db.values():
        crossref = entry.get("crossref")
        if crossref:
            entry["crossref-for-tests"] = crossref

    db = biblib.bib.resolve_crossrefs(db, min_crossrefs=999)

    num_errors = 0
    for entry in db.values():

        def print_error(msg, field):
            nonlocal num_errors
            print(f"[{entry.key}] {msg}: {field}")
            num_errors += 1

        if "author" in entry:
            if len(entry.authors()) >= 3 and "-et-al-" not in entry.key:
                print_error("use -et-al- in bibkey if there are three or more authors", entry["author"])
            elif len(entry.authors()) < 3 and "-et-al-" in entry.key and " and others" not in entry["author"]:
                print_error("use all surnames in bibkey (instead of -et-al-) for papers with 1-2 authors", entry["author"])

        crossref = entry.get("crossref-for-tests")
        if crossref and not re.match(fr"\S*{crossref}[a-z]?", entry.key):
            print_error("crossref does not match bibkey", crossref)

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

            # Match sequences with at least one uppercase letter after the first position that are not enclosed in curly braces:
            # - (?<!\{) and (?!\}) are negative lookbehind and lookahead assertions to ensure that the match is not enclosed in curly braces
            # - \b asserts a word boundary
            # - [a-zA-Z0-9]+ matches one or more alphanumeric characters
            # - [A-Z] matches an uppercase letter
            # - \S* matches zero or more non-whitespace characters
            if re.search(r"(?<!\{)\b[a-zA-Z0-9]+[A-Z]\S*\b(?!\})", entry.get("title", "")):
                print_error("escape (partially) uppercase word in title field with curly braces", entry["title"])

    if num_errors:
        sys.exit(f"Found {num_errors} errors.")


if __name__ == "__main__":
    main()
