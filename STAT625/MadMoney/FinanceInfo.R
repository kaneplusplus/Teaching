
dt <- strptime(paste(2010, 07, 12, sep='-'), "%Y-%m-%d")

GetFinanceInfo <- function(symbol, year, month, day)
{
  dt <- as.Date(paste(year, month, day, sep="-", "%Y-%m-%d"))
  endDate <- unlist(strsplit(as.character(dt+5), '-'))

  url <- paste('http://ichart.finance.yahoo.com/table.csv?s=', symbol, 
    '&a=', as.numeric(month)-1, '&b=', day, '&c=', year, 
    '&d=', as.numeric(endDate[2])-1, '&e=', endDate[3], '&f=', endDate[1], 
    '&g=d&ignore=.csv', 
    sep='')
  ret <- read.csv(url)
  return(ret[c(nrow(ret), nrow(ret)-1),])
}

