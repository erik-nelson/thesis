# Build twice to populate table of contents
pdflatex thesis.tex
bibtex thesis
pdflatex thesis.tex > /dev/null 2>&1
./clean.sh
