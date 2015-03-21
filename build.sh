#!/bin/bash

# Build twice to populate table of contents
TOP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${TOP_DIR}

pdflatex thesis.tex
bibtex thesis
pdflatex thesis.tex > /dev/null 2>&1
./clean.sh

cd -
