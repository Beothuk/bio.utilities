SQL.in <- function(x) {
  #//MMM, Dec, 2015
  #//Takes a vector, and converts it into a comma separated list of characters
  #//appropriate for a SQL IN clause(e.g. c(a,b,c)-> 'a','b','c')
  paste(unlist(gsub("(.*)","'\\1'",x)),sep="",collapse=",")
}
SQL.in.noquotes <- function(x) {
  #//MMM, Dec, 2015
  #//Same as SQL.in, but appropriate for numbers (not vectors), since no 
  #//apostrophes are added (e.g. c(1,2,3)-> 1,2,3)
  paste(unlist(gsub("(.*)","\\1",x)),sep="",collapse=",")
}