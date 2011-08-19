library(XML)

doc <- htmlParse("example.html", error=function(...){})

trDoc <- getNodeSet(doc, '//tr')

# Searching in an element vs searching the entire document.

getNodeSet( trDoc[[2]], './/td' )

getNodeSet( trDoc[[2]], '//td' )

# Get the rows and columns of the first table.

tableNodes <- getNodeSet(doc, '//table')

cellNodes <- getNodeSet(tableNodes[[1]], './/td')

cellVals <- rep(NA, length(cellNodes))

for (i in 1:length(cellNodes)) {
  cellVals[i] <- xmlValue(cellNodes[[i]])
}

mat <- matrix(cellVals, nrow=2, byrow=TRUE)
