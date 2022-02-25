.PHONY: pdf
pdf:        ## Make the final pdf (uses latexmk).
pdf: ext
	latexmk -pdf dmp.tex


.PHONY: clean
clean:      ## Clean up the working directory.
	latexmk -c
	#-rm schemata/c_*.pdf


.PHONY: ext
ext:        ## Make everything pdflatex needs, except for ods2csv.
ext: graphssim svgfigures croppedfigures

.PHONY: help
help:       ## Show this help.
	@grep -F -h "##" $(MAKEFILE_LIST) | sed -e '/unique_BhwaDzu7C/d;s/\\$$//;s/##//'

.PHONY: test
test:       ## Run tests.
	./tests


sim/graf-%.tex: sim/graf-%.gpi sim/graf-common.gpi sim/%.txt
	cd sim && gnuplot $(patsubst sim/%, %, $<)

.PHONY: graphssim
graphssim: $(addsuffix .tex, $(basename $(filter-out sim/graf-common.gpi, $(wildcard sim/graf-*.gpi))))


.PHONY: svgfigures
%.pdf: %.svg
	inkscape -D -z --file=$< --export-pdf=$@
svgfigures: $(addsuffix .pdf, $(basename $(wildcard figures/*.svg)))


.PHONY: croppedfigures
figures/cropped_%.pdf: figures/cropme_%.pdf
	pdfcrop --pdfversion 1.5 $< $@
croppedfigures: $(patsubst figures/cropme_%.pdf,figures/cropped_%.pdf,$(wildcard figures/cropme_*.pdf))
