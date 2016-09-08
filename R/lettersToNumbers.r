#' @title lettersToNumbers
#' @description replaces all letters (lower and upper case) with associated digits (A-Z 1-26) the better way!
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
lettersToNumbers <- function(x) {
  dframe <- data.frame(l=c(letters[],LETTERS[]),num=rep(1:length(letters[]),2))
  return(as.character(dframe[match(x,dframe$l),"num"]))
}