SQL.in <- function(x) {
  #//MMM, Dec, 2015
  #//Takes a vector, and converts it into a comma separated list of characters
  #//appropriate for a SQL IN clause(e.g. c(a,b,c)-> 'a','b','c')
  paste(unlist(gsub("(.*)","'\\1'",x)),sep="",collapse=",")
}
