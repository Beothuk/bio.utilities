#' @title FB2C
#' @description catch given Fishing mortality and Biomass; useful for  projections
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
#

FB2C <- function(F,B) {
	C = B*(exp(F)-1)*exp(-F)
	return(C)
}