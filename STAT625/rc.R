# Challenge 0

2^38

# Challenge 1

text <- "g fmnc wms bgblr rpylqjyrc gr zw fylb. rfyrq ufyr amknsrcpq ypc dmp. bmgle gr gl zw fylb gq glcddgagclr ylb rfyr'q ufw rfgq rcvr gq qm jmle. sqgle qrpgle.kyicrpylq() gq pcamkkclbcb. lmu ynnjw ml rfc spj."
twoShift <- function(text) {
  tv <- strsplit(text, '')[[1]]
  ti <- match( tv, letters )
  ti[ti=='25'] <- -1 
  ti[ti=='26'] <- 0
  ti <- ti + 2
  message <- letters[ti]
  nas <- is.na(message)
  message[nas] <- tv[nas]
  return(paste(message, collapse=''))
}
twoShift(text)
twoShift('map')

# Challenge 2
# The comment variable gets the comment at the bottom of the page.

cv <- strsplit(comment, '')[[1]]
inds <- gregexpr("[A-Za-z]", comment)[[1]]
paste(cv[inds], collapse='')

# Challenge 3
# The comment variable gets the comment at the bottom of the page.

cv <- strsplit(comment, '')[[1]]
inds <- gregexpr('[^A-Z][A-Z][A-Z][A-Z][a-z][A-Z][A-Z][A-Z][^A-Z]', 
  comment, perl=TRUE)[[1]] + 4
paste(cv[inds], collapse='')

# Challenge 4

urlBase <- 'http://www.pythonchallenge.com/pc/def/linkedlist.php?nothing='
#nothing <- '12345'
nothing <- '33110'

while (!is.null(nothing)) {
  text <- paste(scan( paste(urlBase, nothing, sep=''), 
    url, what='character'), collapse=' ')
  if (length(grep("and the next nothing is ", text)) == 1) {
    re <- unlist(gregexpr("[0-9]+", text))
    nothing <- substr(text, re[length(re)], nchar(text))
    print(text)
  }
  else {
    print(text)
    nothing <- NULL
  }
}


