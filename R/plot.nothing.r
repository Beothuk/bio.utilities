#' @title plot.nothing
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
plot.nothing<- function() {
	op<-par(mar=c(0,0,0,0))
	plot(c(0,1),c(0,1),ann=F,bty='n',type='n',xaxt='n',yaxt='n')
	par(op)
}