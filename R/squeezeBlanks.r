#' @title squeezeBlanks
#' @description removes leading blanks
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
squeezeBlanks <- function (text) 
{
    gsub(" *", "", text)
}