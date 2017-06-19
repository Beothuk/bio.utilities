#' @title geomean
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
geomean <- function(x){
	x = exp(mean(log(x+median(x))))-median(x)
	return(x)
}
