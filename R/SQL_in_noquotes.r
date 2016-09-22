#' @title SQL_in_noquotes
#' @description Same as SQL.in, but appropriate for numbers (not vectors), since no apostrophes are added (e.g. c(1,2,3)-> 1,2,3)
#' @family abysmally documented
#' @author  Mike McMahon, \email{Mike.McMahon@@dfo-mpo.gc.ca}
#' @export
SQL_in_noquotes <- function(x) {
  paste(unlist(gsub("(.*)","\\1",x)),sep="",collapse=",")
}