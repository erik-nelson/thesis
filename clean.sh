#!/bin/bash

rm *.aux > /dev/null 2>&1
rm *.pdfsync > /dev/null 2>&1
#rm *.bbl > /dev/null 2>&1
rm *.blg > /dev/null 2>&1
rm *.toc > /dev/null 2>&1
rm *.lof > /dev/null 2>&1
rm *.log > /dev/null 2>&1
rm *.lot > /dev/null 2>&1
rm *.out> /dev/null 2>&1
cd ./content > /dev/null 2>&1
rm *.aux > /dev/null 2>&1
cd - > /dev/null 2>&1
