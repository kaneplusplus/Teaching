library(googleVis)
library(datasets)

data(mtcars)

carSplit <- strsplit(rownames(mtcars), " ")

makes <- c()
models <- c()
for (i in 1:length(carSplit)) {
  carInfo <- carSplit[[i]]
  makes <- c(makes, carInfo[1])
  if (length(carInfo) > 1) {
    models <- c(models, paste(carInfo[-1], collapse = " "))
  } else {
    models <- c(models, makes[length(makes)])
  }
}

mtcars$make <- makes
mtcars$model <- models

bc <- gvisBubbleChart(mtcars, idvar="model", xvar="mpg", yvar="hp", 
  colorvar="make", sizevar="wt", 
  options=list(width=1200, height=800, 
  hAxis="{title: 'MPG'}", vAxis="{title: 'Horsepower'}"))
plot(bc)

bc <- gvisBubbleChart(mtcars, idvar="model", xvar="mpg", yvar="hp", 
  colorvar="cyl", sizevar="wt", 
  options=list(width=1200, height=800,
  hAxis="{title: 'MPG'}", vAxis="{title: 'Horsepower'}"))
plot(bc)

ams <- mtcars$am == 1
mtcars$am[ams] <- "American"
mtcars$am[!ams] <- "Foreign"

bc <- gvisBubbleChart(mtcars, idvar="model", xvar="mpg", yvar="hp", 
  colorvar="am", sizevar="wt", 
  options=list(width=1200, height=800,
  hAxis="{title: 'MPG'}", vAxis="{title: 'Horsepower'}"))
plot(bc)



