#! /bin/bash

set -euxo pipefail

function test() {
    prefix=${1}

    pdflatex ${prefix}.tex
    echo

    # Check for bibtex errors.
    bibtex -min-crossrefs=99 ${prefix}

    # Check for bibtex warnings.
    # Crossrefs without author/editor will show up as standalone entries at the beginning of the bibliography,
    # but they occur too often to be worth fixing.
    (bibtex -min-crossrefs=99 ${prefix} | grep "Warning--" | grep -v "Warning--to sort, need") && exit 1 || exit 0
}

# Change into the directory of this script.
cd "$(dirname "${BASH_SOURCE[0]}")"

cd paper
test "paper"
test "paper-short"
