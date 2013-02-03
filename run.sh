#!/bin/sh

if [ ! -e "augenblicke.json" ]; then
	cd scraper
	./run-scaper.sh
	cd ..
fi

if [ ! -e "augenblicke.csv" ]; then
	python json2csv.py
fi

cd plots
Rscript simpleplots.R
