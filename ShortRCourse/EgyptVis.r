
library(googleVis)

x <- read.csv("H5N1Egypt_2006_2011FULL.csv")

x <- x[grep("2011", x$reportDate),]

x$latlong <- paste(x$latitude, x$longitude, sep=":")

outBreakMap <- gvisMap(x[x$speciesDescription=="Human",], 
  "latlong", "reportDate", 
  options=list(showTip=TRUE, showLine=FALSE, enableScrollWheel=TRUE, 
  mapType='terrain', useMapTypeControl=TRUE, width=1200, height=800))

plot(outBreakMap)

x <- read.csv("H5N1Egypt_2006_2011FULL.csv", as.is=TRUE)
names(x)
names(x)[6] <- "gov"
x$gov[x$gov == "aswan"] <- "Aswan"
x <- x[x$gov == "Cairo" | x$gov == "Matruh" | x$gov == "Aswan", ]

strptime(x$observationDate, format="%d/%m/%Y")
