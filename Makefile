.PHONY: pdf clean help test ext graphssim


pdf:        ## Make the final pdf (uses latexmk).
pdf: ext
	latexmk -pdf dmp.tex


clean:      ## Clean up the working directory.
	latexmk -c
	#-rm schemata/c_*.pdf


ext:        ## Make everything pdflatex needs, except for ods2csv.
ext: graphssim

help:       ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | sed -e '/unique_BhwaDzu7C/d;s/\\$$//;s/##//'

test:       ## Run tests.
	./tests


sim/graf-%.tex: sim/graf-%.gpi sim/graf-common.gpi sim/%.txt
	cd sim && gnuplot $(patsubst sim/%, %, $<)

graphssim: $(addsuffix .tex, $(basename $(filter-out sim/graf-common.gpi, $(wildcard sim/graf-*.gpi))))
