#!/usr/bin/env python
#    BVG Augenblicke Spider: convert json files created by the spider to csv 
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
import json
import csv

json_data=open('augenblicke.json').read()
csv_file = open('augenblicke.csv', 'wb')
writer = csv.writer(csv_file, quoting=csv.QUOTE_MINIMAL)

data = json.loads(json_data)

for item in data:
  if 'linie' in item and 'zeit' in item and 'verfasst' in item:
    writer.writerow([item['linie'], item['zeit'], item['verfasst']])
