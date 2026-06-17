# Installing dependencies

The Python scripts (`sort.py`, `fix.py`, `lint.py`) declare their
dependencies inline ([PEP 723](https://peps.python.org/pep-0723/)) and
run themselves with [uv](https://docs.astral.sh/uv/). Install uv once:

    curl -LsSf https://astral.sh/uv/install.sh | sh

uv then creates an isolated environment and fetches the required
packages automatically the first time a script runs -- no virtualenv or
`pip install` step is needed.

The paper-compilation checks in `run-tests.sh` additionally require a
LaTeX installation (`pdflatex` and `bibtex`).


# Running tests

    ./run-tests.sh

Each script can also be run on its own, e.g.:

    ./lint.py ../abbrv.bib ../literatur.bib ../crossref.bib
