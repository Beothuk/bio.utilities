#' @export
#' @title dist.plt
#' @description plots distributions in R, useful for setting up priors in Bayesian analyses
#' @param \code{dist} 
#' @param \code{par1} 
#' @param \code{par2} 
#' @param \code{x} 
#' @param \code{xl} 
#' @param \code{col} 
#' @return \code{add}
#' @return \code{alpha}
#' @return \code{plot.lines}
#' @family plotting
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
dist.plt<-function(dist="beta",par1,par2,x,xl=c(0,1),col=1,add=F,alpha=0.05,plot.lines=F,title=''){

	
	z<-get(paste("r",dist,sep=''))(1000,par1,par2)
	if(missing(xl))xl<-range(z)
	if(missing(x))x<-seq(xl[1],xl[2],length=1000)
	y<-get(paste("d",dist,sep=''))(x,par1,par2)
	
	if(add==F){
#		plot.new()
		plot(x,y,type='l',col=col,xlab='',ylab='',main=title)
	}
	
	if(add==T)lines(x,y,col=col)
	out<-list(c(quantile(z, alpha/2),quantile(z, 0.5),quantile(z, 1-alpha/2)),mode=x[which(y==max(y))],mean=mean(z),var=var(z))
	if(plot.lines){
  	abline(v=out[[1]][2],lty=2)
	abline(v=out$mean,lty=3)
	abline(v=out$mode,lty=4)
	}
	
	out
	
}
