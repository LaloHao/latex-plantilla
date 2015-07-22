TEXFILE = ejemplo

all: compile copy

compile:
	pdflatex ${TEXFILE}.tex
	makeglossaries ${TEXFILE}
	pdflatex ${TEXFILE}.tex
	makeglossaries ${TEXFILE}
	bibtex ${TEXFILE}.aux
	pdflatex ${TEXFILE}.tex
	pdflatex ${TEXFILE}.tex	

view:
	evince ${TEXFILE}.pdf

copy:
	cp ${TEXFILE}.pdf ../win
