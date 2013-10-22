TEX = pdflatex -shell-escape -interaction=nonstopmode -file-line-error

.PHONY: all view

all : main.pdf

view :
	open main.pdf

main.pdf : main.tex
	$(TEX) main.tex
