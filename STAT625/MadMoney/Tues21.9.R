library(XML)

url <- 'http://www.madmoneyrecap.com/madmoney_pastrecaps.htm'
doc <- htmlParse(url)

nodes <- getNodeSet(doc, 
     "//a[starts-with(@href, 'madmoney_pastrecaps_')]")

a <- rep(NA, length(nodes))
for (i in 1:length(nodes)) {
  a[i] <- as.character(xmlAttrs( nodes[[i]], "@href"))
}

a <- paste('http://www.madmoneyrecap.com/', a, sep="")

doc <- htmlParse(a[1])
