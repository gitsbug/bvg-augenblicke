#!/bin/sh
#    BVG Augenblicke Spider: Download flirt moments from bvg.de/augenblicke
#    Copyright (C) 2013 gitsbug
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Outputfile: where to store the scraped items
JSONFILE="../augenblicke.json"

if [ -s $JSONFILE ]; then
	echo "Error: $JSONFILE already exists. I won't overright results and stop here."
	exit 1
fi

scrapy crawl bvgaugenblicke --set FEED_URI=../augenblicke.json --set FEED_FORMAT=json
