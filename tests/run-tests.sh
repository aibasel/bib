#! /bin/bash

set -euxo pipefail

function test() {
    prefix=${1}

    make clean
    pdflatex ${prefix}.tex
    echo

    # Check for bibtex errors.
    bibtex -min-crossrefs=99 ${prefix}

    # Check for bibtex warnings.
    # Crossrefs without author/editor will show up as standalone entries at the beginning of the bibliography,
    # but they occur too often to be worth fixing.
    (bibtex -min-crossrefs=99 ${prefix} | grep "Warning--" | grep -v "Warning--to sort, need") && return 1 || return 0
}

function check_sorted() {
    name=${1}
    ./sort.py ../${name}.bib ${name}-sorted.bib
    # Exit with 1 if the sorted file is different.
    diff  ../${name}.bib ${name}-sorted.bib
    rm ${name}-sorted.bib
}

function check_format() {
    name=${1}
    ./fix.py ../${name}.bib ${name}-fixed.bib
    # Exit with 1 if the fixed file is different.
    diff  ../${name}.bib ${name}-fixed.bib
    rm ${name}-fixed.bib
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
