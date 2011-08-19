#install.packages("XML")
library(XML)

file <- "example.html"
doc <- htmlParse(file, error=function(...){})

tableDoc <- getNodeSet(doc, '//table')
tableDoc <- getNodeSet(doc, '//table[@border="2"]')
tableDoc <- getNodeSet(doc, '//table[@border and @id="second"]')
tableDoc <- getNodeSet(doc, '//table[@border="5" and @id="second"]')
trDoc1 <- getNodeSet(tableDoc[[1]], './/tr')

b <- getNodeSet(doc, "//td")
xmlValue(b[[1]])
