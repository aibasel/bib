PREFIX = paper
PREFIXSHORT = paper-short
LATEX = pdflatex -interaction=nonstopmode -halt-on-error
BIBTEX = bibtex
BIBINPUTS = ../../
SHELL = /bin/bash

paper:
	$(LATEX) $(PREFIX).tex
	$(BIBTEX) -min-crossrefs=99 $(PREFIX)
	$(LATEX) $(PREFIX).tex
	$(LATEX) $(PREFIX).tex
	$(LATEX) $(PREFIX).tex

test:
	$(LATEX) $(PREFIX).tex
	# Crossrefs without author/editor will show up as standalone entries at the beginning of the bibliography,
	# but they occur too often to be worth fixing.
	($(BIBTEX) -min-crossrefs=99 $(PREFIX) | grep "Warning--" | grep -v "Warning--to sort, need") && exit 1 || exit 0

test-short:
	$(LATEX) $(PREFIXSHORT).tex
	($(BIBTEX) -min-crossrefs=99 $(PREFIXSHORT) | grep "Warning--" | grep -v "Warning--to sort, need") && exit 1 || exit 0

clean:
	rm -f *~ {$(PREFIX),$(PREFIXSHORT)}.{aux,bbl,blg,fdb_latexmk,fls,log,out,synctex.gz}
