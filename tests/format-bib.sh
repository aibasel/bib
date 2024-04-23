#! /bin/bash

set -euo pipefail

# Change into the directory of this script.
cd "$(dirname "${BASH_SOURCE[0]}")"

# Format bibliography.
for name in literatur crossref crossref-short; do
    ./sort.py ../${name}.bib ../${name}.bib
    ./fix.py ../${name}.bib ../${name}.bib
done
