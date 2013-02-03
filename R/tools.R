#    BVG Augenblicke Spider: misc tools for data processing 
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

# The data gives the names for each line (e.g., there are 9 subway lines
# being operated in Berlin, labelled U1 to U9). This function will merge
# lines to clusters: subway (U), city train (S), night bus (Nachtbus),
# tram, regional train (RB/RE), fairy (Fahere), train replacement bus (SEV).
classifyLine <- function(line) {
	if(!is.factor(line)) {
		warning("classifyLine expects factor input")
		return(NA)
	}

	transport <- factor(line, levels=c("U", "S", "Nachtbus", "bus", "tram", "RB/RE", "Faehre", "SEV"))

	levels <- levels(line)

	# U-Bahn: Metro lines 
	transport[line %in% c("U1", "U2", "U3", "U4", "U5", "U55", "U6", "U7", "U8", "U9")] <- "U"

	# S-Bahn lines (city trains)
	transport[line %in% c("S1", "S2", "S25", "S3", "S41", "S42", "S45", "S46", "S47", "S5", "S7", "S75", "S8", "S85", "S9")] <- "S"
	
	# Regional trains
	transport[line %in% c("RB 10", "RB 12", "RB 14", "RB 21", "RE 1", "RE 2", "RE 3", "RE 4", "RE 5", "RE 6", "RE 7")] <- "RB/RE"

	# Bus lines
	#
	# Express bus lines
	transport[line %in% levels[grep("^X[0-9]+$", levels)]] <- "bus"
	transport[line == "TXL"] <- "bus"
	#
	# Metro bus lines
	transport[line %in% levels[grep("^M[0-9]+$", levels)]] <- "bus"
	# Stadtbusse: City bus lines (3 digits)
	transport[line %in% levels[grep("^[0-9]{3}$", levels)]] <- "bus"
	# Nachtbusse: Night bus lines
	transport[line %in% levels[grep("^N[0-9]+$", levels)]] <- "Nachtbus"

	# Faehren: ferrys
	transport[line %in% levels[grep("^F[0-9]+$", levels)]] <- "Faehre"

	# Trams
	# Metro trams
	transport[line %in% levels[grep("^M[0-9]$", levels)]] <- "tram"
	transport[line %in% c("M10", "M13", "M17")] <- "tram"
	# 2 Stellige Linien
	transport[line %in% levels[grep("^[0-9]{2}$", levels)]] <- "tram"

	# rail replacement buses
	transport[line == "Schienenersatzverkehr"] <- "SEV"

	return(transport)
}

# Translate the classified lines
translateLineVector <- function(lines, de=F) {
  labels_translated <- c("Subway", "City Train", "Bus", "Tram", "Train", "Night Bus", "Rail Replacement Bus", "Ferry")
  if (de) {
    labels_translated <- c("U-Bahn", "S-Bahn", "Bus", "Tram", "RB/RE", "Nachtbus", "SEV", "Faehre")
  }
  
  return(factor(augenblicke$transportation,
                levels=c("U", "S", "bus", "tram", "RB/RE", "Nachtbus", "SEV", "Faehre"),
                labels=labels_translated))
}
