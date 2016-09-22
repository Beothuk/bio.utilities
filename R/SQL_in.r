#' @title SQL_in
#' @description Takes a vector, and converts it into a comma separated list of characters appropriate for a SQL IN clause(e.g. c(a,b,c)-> 'a','b','c')
#' @family abysmally documented
#' @author  Mike McMahon, \email{Mike.McMahon@@dfo-mpo.gc.ca}
#' @export
SQL_in <- function(x) {
  paste(unlist(gsub("(.*)","'\\1'",x)),sep="",collapse=",")
}
