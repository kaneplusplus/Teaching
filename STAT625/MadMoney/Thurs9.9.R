scrapesegment <- function(url) {
  text <- scan(url, what=character(), sep="\n")
  I <- grep("icon_thm2_[a-z]*.gif", text)

  up <- grep("icon_thm2_up.gif", text)
  down <- grep("icon_thm2_down.gif", text)
  updown <- c(up, down)
  I <- updown
  updown <- rep("down", length(I))
  updown[1:length(up)] <- "up"

  symbol <- rep(NA, length(I))
  price <- rep(NA, length(I))
  urls <- rep(NA, length(I))

  for(i in 1:length(I) ) {
    subtext <- text[I[i]:(I[i]+10)]
    line <- subtext[min(grep("finance.yahoo.com", subtext))]
    regout <- regexpr("http://[^=]*=[A-Za-z-]+", 
                      line, perl=TRUE)
    urls[i] <- substr(line, regout[1], 
                      regout[1] + attributes(regout)[[1]]-1)
    symbol[i] <- unlist(strsplit(urls[i], "="))[2]
  }

  return(data.frame(symbol = symbol, updown = updown, url = urls))
}

url <- "http://www.madmoneyrecap.com/madmoney_nightlyrecap_100908_4.htm"
scrapesegment(url)







