SQL.in.noquotes <- function(x) {
  #//MMM, Dec, 2015
  #//Same as SQL.in, but appropriate for numbers (not vectors), since no 
  #//apostrophes are added (e.g. c(1,2,3)-> 1,2,3)
  paste(unlist(gsub("(.*)","\\1",x)),sep="",collapse=",")
}