
url <- "http://www.madmoneyrecap.com/madmoney_nightlyrecap_100908_4.htm"

text <- scan(url, what=character(), sep="\n")

regexpr("finance", string)
string <- text[1851]
substr(string, 14, 20)

gregexpr("[A-Z]+", string, perl=TRUE)

unlist(strsplit(text, "<[^>]*?>", perl=TRUE))



