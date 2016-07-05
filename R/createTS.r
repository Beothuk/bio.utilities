#' @export
#' @title createTS
#' @description creates a random time series of data of length N, not perfect but works
#' @param \code{N} = the number of values desired (Defaults to 100)
#' @param \code{seed} (Defaults to \code{null})
#' @param \code{nonstationary} (Defaults to T)
#' @param \code{all.positive} = if you want all values positive set all.positive=T to rescale (Defaults to T)
#' @return \code{x} 
#' @author unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @family random data
#' @examples
#' createTS(8,nonstationary=T,all.positive=F)
#' [1]  0.0000000  0.6036440  0.8781622  0.8489549  1.3040091  0.5772213  0.2788312 -0.2574978 -0.6370382
#' @references \url{http://stats.stackexchange.com/questions/29239/creating-auto-correlated-random-values-in-r}
#' @export
createTS <- function(N=100,seed=NULL, nonstationary=T,all.positive=T) {
if(!is.null(seed)) set.seed(seed)
		if(nonstationary) {
			#brownian motion
				x = diffinv(rnorm(N))
			}		
		if(!nonstationary) {
				x = filter(rnorm(N), filter=rep(1,3), circular=TRUE)
			}
		if(all.positive & min(x)<0) {
			x = x-min(x)+abs(min(x)*0.25)
			}
	return(x)
}