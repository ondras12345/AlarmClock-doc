.PHONY: pdf
pdf:        ## Make the final pdf (uses latexmk).
pdf: ext
	latexmk -pdf dmp.tex


.PHONY: clean
clean:      ## Clean up the working directory.
	latexmk -c
	-rm figures/cropped_*.pdf sim/cropped_*.pdf
	#-rm schemata/c_*.pdf


.PHONY: ext
ext:        ## Make everything pdflatex needs.
ext: graphssim svgfigures croppedfigures gnuplotfigures croppedsim LCDchars.tex

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

.PHONY: gnuplotfigures
figures/graf-%.tex: figures/graf-%.gpi figures/graf-common.gpi
	cd figures && gnuplot $(patsubst figures/%, %, $<)
gnuplotfigures: $(addsuffix .tex, $(basename $(filter-out figures/graf-common.gpi, $(wildcard figures/graf-*.gpi))))


.PHONY: croppedsim
sim/cropped_%.pdf: sim/cropme_%.pdf
	pdfcrop --pdfversion 1.5 $< $@
croppedsim: $(patsubst sim/cropme_%.pdf,sim/cropped_%.pdf,$(wildcard sim/cropme_*.pdf))


LCDchars.tex: prilohy/AlarmClock/lib/GUI/LCDchars.cpp
	./script/LCDchars
