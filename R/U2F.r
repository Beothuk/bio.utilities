#' @title U2F
#' @description exploitation rate to fishing mortality
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
U2F <- function(U){
	return(-log(1-U))
}