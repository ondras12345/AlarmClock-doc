.PHONY: pdf clean help test


pdf:        ## Make the final pdf (uses latexmk).
#pdf: ext
	latexmk -pdf dmp.tex


clean:      ## Clean up the working directory.
	latexmk -c
	#-rm schemata/c_*.pdf


ext:        ## Make everything pdflatex needs, except for ods2csv.
#ext: sch tables graphs graphscalc graphsuvod

help:       ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | sed -e '/unique_BhwaDzu7C/d;s/\\$$//;s/##//'

test:       ## Run tests.
	./tests
