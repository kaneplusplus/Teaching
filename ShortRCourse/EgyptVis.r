
library(googleVis)

x <- read.csv("H5N1Egypt_2006_2011FULL.csv")

x <- x[grep("2011", x$reportDate),]

x$latlong <- paste(x$latitude, x$longitude, sep=":")

outBreakMap <- gvisMap(x[x$speciesDescription=="Human",], 
  "latlong", "reportDate", 
  options=list(showTip=TRUE, showLine=FALSE, enableScrollWheel=TRUE, 
  mapType='terrain', useMapTypeControl=TRUE, width=1200, height=800))

plot(outBreakMap)

x <- read.csv("EgyptOutbreakData.csv")
x <- x[grep("2011", x$date),]
x$date <- as.Date(x$date)
y1 <- x[,c("human", "date", "temp", "humidity")]
names(y1)[1] <- "outbreak"
y2 <- x[,c("bird", "date", "temp", "humidity")]
names(y2)[1] <- "outbreak"
y1$species <- "human"
y2$species <- "bird"
y <- rbind(y1, y2)
y <- y[,c("species", "date", "outbreak", "temp", "humidity")]
plot(gvisMotionChart(y, idvar="species", timevar="date"))

plot(gvisMotionChart(Fruits, idvar="Fruit", timevar="Year"))

