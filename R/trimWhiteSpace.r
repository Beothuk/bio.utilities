#' @title trimWhiteSpace
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
trimWhiteSpace <- function (x) gsub("^\\s+|\\s+$", "", x)