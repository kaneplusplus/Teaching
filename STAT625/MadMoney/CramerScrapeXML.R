library(XML)

Scrape2010Segment <- function(scrapeUrl)
{
  doc <- try(htmlParse(scrapeUrl, error=function(...){}), silent=TRUE)
  if (class(doc)[1] == 'try-error')
    return(data.frame(symbol=c(), recommend=c(), url=c()))
  stockTable <- getNodeSet(doc, '//table[@border and @cellpadding and @width and @bordercolor and @id]')[[1]]
  tableRows <- getNodeSet(stockTable, './/tr')

  symbol <- rep(NA, length(tableRows)-2)
  recommend <- symbol
  url <- recommend
  
  if (length(tableRows) < 3)
    return(data.frame(symbol=symbol, recommend=recommend, url=url))
  for (i in 3:(length(tableRows)))
  {
    cells <- getNodeSet(tableRows[[i]], './/td')
    if (length(cells) == 4)
    {
      # Get the recommendation (note: it may be neither thumbs up or down).
      iconTag <- getNodeSet(cells[[1]], 
        './/img[starts-with(@src, "icon_thm2_")]')
      symbolTag <- getNodeSet(cells[[2]], 
        './/a[starts-with(@href, "http://finance.yahoo.com/")]')
      if (length(iconTag) > 0 && length(symbolTag) > 0)
      {
        iconName <- xmlGetAttr(iconTag[[1]], 'src')
        if (iconName == "icon_thm2_up.gif") {
          recommend[i-2] <- TRUE
        } else if  (iconName == "icon_thm2_down.gif")
          recommend[i-2] <- FALSE
      
        tempUrl <- xmlGetAttr(symbolTag[[1]], "href")
        if (length(tempUrl) > 0) {
          url[i-2] <- tempUrl
          symbol[i-2] <- substr(tempUrl, regexpr("[^=]=", tempUrl)+2, 
            nchar(tempUrl))
        }
      }
    }
  }
  return(na.omit(
    data.frame(symbol=symbol, recommend=recommend, url=url)))
}

Scrape2009Segment <- function(scrapeUrl)
{
#  print(scrapeUrl)
  doc <- try(htmlParse(scrapeUrl, error=function(...){}), silent=TRUE)
  if (class(doc)[1] == 'try-error')
    return(data.frame(symbol=c(), recommend=c(), url=c()))
  stockTable <- getNodeSet(doc, '//table[@border and @cellpadding and @width and @bordercolor and @id]')#[[2]]
  if (length(stockTable) < 2)
    return(data.frame(symbol=c(), recommend=c(), url=c()))
  stockTable = stockTable[[2]]
#  if (length(stockTable) < 3) {
#    cat("problem at page", scrapeUrl, "\n")
#    return(data.frame(symbol=c(), recommend=c(), url=c()))
#  }
    
  tableRows <- getNodeSet(stockTable, './/tr')

  if (length(tableRows) < 2)
    return(data.frame(symbol=symbol, recommend=recommend, url=url))
  symbol <- rep(NA, length(tableRows)-1)
  recommend <- symbol
  url <- recommend
  for (i in 2:length(tableRows))
  {
    cells <- getNodeSet(tableRows[[i]], './/td')
    if (length(cells) == 4)
    {
      # Get the recommendation (note: it may be neither thumbs up or down).
      iconTag <- getNodeSet(cells[[1]],
        './/img[starts-with(@src, "images/icon_thm_")]')
      if (length(iconTag) == 0)
        iconTag <- getNodeSet(cells[[1]],
          './/img[starts-with(@src, "icon_thm_")]')
      symbolTag <- getNodeSet(cells[[2]],
        './/a[starts-with(@href, "http://finance.yahoo.com/")]')
      if (length(iconTag) > 0 && length(symbolTag) > 0)
      {
        iconName <- xmlGetAttr(iconTag[[1]], 'src')
        if (iconName == "images/icon_thm_up.gif" || 
          iconName == "icon_thm_up.gif") {
          recommend[i-1] <- TRUE
        } else if  (iconName == "images/icon_thm_down.gif" || 
          iconName == "icon_thm_down.gif")
          recommend[i-1] <- FALSE

        tempUrl <- xmlGetAttr(symbolTag[[1]], "href")
        if (length(tempUrl) > 0) {
          url[i-1] <- tempUrl
          symbol[i-1] <- substr(tempUrl, regexpr("[^=]=", tempUrl)+2,
            nchar(tempUrl))
        }
      }
    }
  }
  return(na.omit(
    data.frame(symbol=symbol, recommend=recommend, url=url)))
}




ScrapeQuarter <- function( scrapeUrl )
{
  urlRoot <- 'http://www.madmoneyrecap.com'
  doc <- htmlParse( scrapeUrl, error=function(...){})
  recapNodes <- getNodeSet(doc, 
    '//a[starts-with(@href, "madmoney_nightlyrecap_")]')
  data <- NULL
  
  is2009 <- substr(scrapeUrl, 52, 53) == "09"
  for (i in 1:length(recapNodes)) {
    rs <- xmlGetAttr(recapNodes[[i]], "href")
    for (j in 1:6)
    {
      su <- paste(urlRoot, "/", substr(rs, 1, 28), "_", as.character(j), ".htm",
        sep='')
      if (is2009) {
        recap <- Scrape2009Segment(su)
      } else {
        recap <- Scrape2010Segment(su)
      }
      if (nrow(recap) > 0)
      {
        recap$year <- paste("20", substr(rs, 23, 24), sep='')
        recap$month <- substr(rs, 25, 26)
        recap$day <- substr(rs, 27, 28)
        if (!is.null(recap))
          data <- rbind(data, recap)
      }
    }
    cat("Scraped episode", i, "of", length(recapNodes), "\n")
  }
  return(data)
}

urlBase <- 'http://www.madmoneyrecap.com/'
doc <- htmlParse(paste(urlBase, '/madmoney_pastrecaps.htm', sep=''), 
  error=function(...){})
qtrNodes <- getNodeSet(doc, '//a[starts-with(@href, "madmoney_pastrecaps_")]')
qtrUrls <- rep(NA, length(qtrNodes))
for (i in 1:length(qtrNodes)) {
  qtrUrls[i] <- xmlGetAttr(qtrNodes[[i]], "href")
}
data <- NULL
for (url in qtrUrls[1:length(qtrUrls)]) {
  data <- rbind(data, ScrapeQuarter(paste(urlBase, url, sep='')))
  cat("Scraped quarter number", which(qtrUrls==url), "of", length(qtrUrls), 
    "\n")
}
data <- unique(data)
