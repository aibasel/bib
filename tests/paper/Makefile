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
	$(LATEX) $(PREFIX).tex > /dev/null
	($(BIBTEX) -min-crossrefs=99 $(PREFIX) | grep "Warning--" | grep -v "Warning--to sort, need editor or key in") && exit 1

test-short:
	$(LATEX) $(PREFIXSHORT).tex > /dev/null
	($(BIBTEX) -min-crossrefs=99 $(PREFIXSHORT) | grep "Warning--" | grep -v "Warning--to sort, need editor or key in") && exit 1

clean:
	rm -f *~ {$(PREFIX),$(PREFIXSHORT)}.{aux,bbl,blg,fdb_latexmk,fls,log,out,synctex.gz}
