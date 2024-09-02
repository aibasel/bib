#! /bin/bash

set -euxo pipefail

function test() {
    prefix=${1}

    make clean
    pdflatex -quiet ${prefix}.tex
    echo

    # Check for bibtex errors.
    bibtex -min-crossrefs=99 ${prefix}

    # Check for bibtex warnings.
    # Crossrefs without author/editor will show up as standalone entries at the beginning of the bibliography,
    # but they occur too often to be worth fixing.
    (bibtex -min-crossrefs=99 ${prefix} | grep "Warning--" | grep -v "Warning--to sort, need") && return 1

    pdflatex -quiet ${prefix}.tex
}

function check_diff_and_remove() {
    actual=${1}
    expected=${2}
    # diff exists with 1 if the files differ.
    diff ${actual} ${expected} || (echo Files differ. Check diff with \"meld ${actual} ${expected}\" ; exit 1)
    rm ${expected}
}

function check_sorted() {
    name=${1}
    ./sort.py ../${name}.bib ${name}-sorted.bib
    check_diff_and_remove ../${name}.bib ${name}-sorted.bib
}

function check_format() {
    name=${1}
    ./fix.py ../${name}.bib ${name}-fixed.bib
    check_diff_and_remove ../${name}.bib ${name}-fixed.bib
}

# Change into the directory of this script.
cd "$(dirname "${BASH_SOURCE[0]}")"

# Compile all citations in a paper.
cd paper
export BIBINPUTS=../../
test "paper"
test "paper-short"
cd ../

# Check that the bibliography files are sorted.
check_sorted literatur
check_sorted crossref
check_sorted crossref-short

# Check that the bibliography files are formatted correctly.
check_format literatur
check_format crossref
check_format crossref-short

# Run some basic checks on the bibliography files.
./lint.py ../abbrv.bib ../literatur.bib ../crossref.bib
./lint.py ../abbrv.bib ../literatur.bib ../crossref-short.bib

echo "All tests passed."
