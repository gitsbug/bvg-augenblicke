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

# This will create a barplot showing the number of moments for each
# transportation means. 
plotTransportationMeansSimple <- function(augenblicke, de=FALSE) {
  xlab <- "Means of Transportation"
  ylab <- "Moments [%]"
  
  if (de) {
    xlab <- "Transportmittel"
    ylab <- "Augenblicke [%]"
  }
  
  plotdf <- augenblicke
  plotdf$transportation <- translateLineVector(augenblicke$transportation, de)

  p <- ggplot(plotdf,
         aes(x=reorder(
           transportation,
           transportation,
           function(x)-length(x)
         )
    )) +
    theme(axis.text.x=element_text(angle=-90)) +
    xlab(xlab) +
    ylab(ylab) +
    geom_bar(aes(y=..count../sum(..count..)*100),colour="black",fill="orange")
  
  return(p)
}

# This will generate a stacked barplot where each bar represents a weekday
# and the bar shows the means of transportation.
plotTransportationMeansWeekdays <- function(augenblicke, de=FALSE) {
  xlab <- "Weekday"
  ylab <- "# Moments"
  
  if (de) {
    xlab <- "Wochentag"
    ylab <- "# Augenblicke"
  }
  
  plotdf <- augenblicke
  plotdf$transportation <-  translateLineVector(augenblicke$transportation, de)
  if (de) {
    wdays <- c("Mo", "Di", "Mi", "Do", "Fr", "Sa", "So")
  } else {
    wdays <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
  }
  plotdf$wdays <- factor(
    weekdays(plotdf$spottime, abbreviate=T),
    levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"),
    labels = wdays,
    ordered=T
  )
  
  p <- ggplot(plotdf,
         aes(x=wdays,
             fill = transportation
         )) +
    theme(axis.text.x=element_text(angle=-90)) +
    xlab(xlab) +
    ylab(ylab) +
    geom_bar()
  
  return(p)
}

# This will generate a stacked barplot where each bar represents an hour
# and the bar shows the means of transportation.
plotTransportationMeansHours <- function(augenblicke, de=FALSE) {
  xlab <- "Hour"
  ylab <- "# Moments"
  
  if (de) {
    xlab <- "Stunde"
    ylab <- "# Augenblicke"
  }
  
  plotdf <- augenblicke
  plotdf$transportation <- translateLineVector(augenblicke$transportation, de)
  
  p <- ggplot(plotdf,
         aes(x=factor(format(spottime, "%H")),
             fill = transportation
         )) +
    theme(axis.text.x=element_text(angle=-90)) +
    xlab(xlab) +
    ylab(ylab) +
    geom_bar()
  return(p)
}

# Stacked bar plot: hours vs. week days
plotHoursDays <- function(augenblicke, de=FALSE) {
  xlab <- "Hour"
  ylab <- "# Moments"
  
  if (de) {
    xlab <- "Stunde"
    ylab <- "# Augenblicke"
  }
  
  plotdf <- augenblicke
  plotdf$transportation <- translateLineVector(augenblicke$transportation, de)
  if (de) {
    wdays <- c("Mo", "Di", "Mi", "Do", "Fr", "Sa", "So")
  } else {
    wdays <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
  }
  plotdf$wdays <- factor(
    weekdays(plotdf$spottime, abbreviate=T),
    levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"),
    labels = wdays,
    ordered=T
  )
  
  p <- ggplot(plotdf,
         aes(x=factor(format(spottime, "%H")),
             fill = wdays
         )) +
    theme(axis.text.x=element_text(angle=-90)) +
    xlab(xlab) +
    ylab(ylab) +
    geom_bar()
  return(p)
}

# Stacked bar plot: one bar for each day of a selected month and
# the frequency for each year as stacked bars.
plotDaysMonth <- function(augenblicke, month, de=F) {
  xlab <- "Day"
  ylab <- "# Moments"
  legendlab <- "Year"
  
  if (de) {
    xlab <- "Tag"
    ylab <- "# Augenblicke"
    legendlab <- "Jahr"
  }
  
  plotdf <- augenblicke[format(augenblicke$spottime, "%m")==month,]
  p <- ggplot(plotdf,
              aes(x=factor(format(spottime, "%d")),
                  fill = factor(format(spottime, "%Y"))
              )) +
    theme(axis.text.x=element_text(angle=-90)) +
    xlab(xlab) +
    ylab(ylab) +
    scale_fill_discrete(legendlab) +
    geom_bar()
  
  return(p)
}