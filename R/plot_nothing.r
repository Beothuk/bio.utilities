#' @title plot_nothing
#' @description unknown
#' @family abysmally documented
#' @author  Adam Cook, \email{Adam.Cook@@dfo-mpo.gc.ca}
#' @export
plot_nothing<- function() {
	op<-par(mar=c(0,0,0,0))
	plot(c(0,1),c(0,1),ann=F,bty='n',type='n',xaxt='n',yaxt='n')
	par(op)
}