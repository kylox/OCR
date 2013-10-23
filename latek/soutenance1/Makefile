TEX = pdflatex -shell-escape -interaction=nonstopmode -file-line-error

.PHONY: all view

all : rapport.pdf

view :
	evince rapport.pdf

rapport.pdf : rapport.tex
	$(TEX) rapport.tex

clean ::
	rm -f *.aux *.log *.pdf *.toc
