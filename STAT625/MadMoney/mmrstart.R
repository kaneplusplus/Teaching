library(XML)

url <- 'http://www.madmoneyrecap.com/madmoney_pastrecaps.htm'

doc <- htmlParse(url, error=function(...){})
getNodeSet(doc, '//a [@href="madmoney_pastrecaps_3Q10.htm"]')
nodes <- getNodeSet(doc, '//a[starts-with(@href, "madmoney_pastrecaps_")]')

recapUrls <- rep(NA, length(nodes))
for (i in 1:length(nodes)) {
  recapUrls[i] <- xmlGetAttr(nodes[[i]], 'href')
}


doc <- htmlParse(
  paste('http://www.madmoneyrecap.com', recapUrls[1], sep="/"))

