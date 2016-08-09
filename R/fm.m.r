#' @title fm.m
#' @description fathoms to m
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
fm.m<-function(x) {
	m <- x*(6*12*2.54)/100
	return(m)
}