.PHONY: pdf
pdf:        ## Make the final pdf (uses latexmk).
pdf: ext
	latexmk -pdf dmp.tex


.PHONY: clean
clean:      ## Clean up the working directory.
	latexmk -c
	-rm figures/cropped_*.pdf sim/cropped_*.pdf \
	    hodnoty/graf-*.tex hodnoty/graf-*.eps \
	    hodnoty/graf-*-eps-converted-to.pdf hodnoty/fit.log
	#-rm schemata/c_*.pdf


.PHONY: ext
ext:        ## Make everything pdflatex needs.
ext: graphssim svgfigures croppedfigures gnuplotfigures croppedsim LCDchars.tex tables graphs

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

# remove comments and trailing semicolons ; decimal points instead of commas,
# commas instead of semicolons
hodnoty/c_%.csv: hodnoty/e_%.csv
	sed '/^[[:blank:]]*#/d;s/#.*//;s/\;*$$// ; s/,/./g;s/;/,/g' $< > $@

# dollar sign needs to be doubled because of make
hodnoty/c_%.tex: hodnoty/c_%.csv
	sed '1d;s/,/ \& /g;s/$$/ \\\\/g' $< > $@

.PHONY: tables
tables: $(addsuffix .tex, $(basename $(patsubst hodnoty/e_%.csv,hodnoty/c_%.csv,$(wildcard hodnoty/e_*.csv))))


hodnoty/graf-%.tex: hodnoty/graf-%.gpi hodnoty/graf-common.gpi hodnoty/c_%.csv
	@if grep --color=auto -H "set output.*\\.gpi[\"']\$$" $< ; then echo "Don't overwrite your gpi!"; exit 1 ; else exit 0 ; fi
	cd hodnoty && gnuplot $(patsubst hodnoty/%,%, $<)

.PHONY: graphs
graphs: $(addsuffix .tex, $(basename $(filter-out hodnoty/graf-common.gpi, $(wildcard hodnoty/graf-*.gpi))))
