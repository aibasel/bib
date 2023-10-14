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

paper-short:
	$(LATEX) $(PREFIXSHORT).tex
	$(BIBTEX) -min-crossrefs=99 $(PREFIXSHORT)
	$(LATEX) $(PREFIXSHORT).tex
	$(LATEX) $(PREFIXSHORT).tex
	$(LATEX) $(PREFIXSHORT).tex

clean:
	rm -f *~ {$(PREFIX),$(PREFIXSHORT)}.{aux,bbl,blg,fdb_latexmk,fls,log,out,synctex.gz}
