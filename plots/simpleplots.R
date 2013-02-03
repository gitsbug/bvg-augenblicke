#    BVG Augenblicke Spider: create some basic plots with ggplots 
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

source("../R/readcsv.R")
source("../R/tools.R")
source("../R/plots.R")

library(ggplot2)

width <- 600
heigth <- 400

augenblicke <- readAugenblickeCsv("../augenblicke.csv")
augenblicke$transportation <- classifyLine(augenblicke$line)

for (de in c(T, F)) {
	lang <- "en"
	if (de) lang <- "de"

	print(paste(lang, de, "moments-hours-vs-days.png", sep="-"))
	png(filename=paste(lang, "moments-hours-vs-days.png", sep="-"), width=width, height=heigth)
	print(plotHoursDays(augenblicke, de=de))
	dev.off()

	png(filename=paste(lang, "moments-transportation-weekdays.png", sep="-"), width=width, height=heigth)
	print(plotTransportationMeansWeekdays(augenblicke, de=de))
	dev.off()

	png(filename=paste(lang, "moments-transportation-hours.png", sep="-"), width=width, height=heigth)
	print(plotTransportationMeansHours(augenblicke, de=de))
	dev.off()
}