createTS <- function(N=100,seed=NULL, nonstationary=T,all.positive=T) {
	#creates a random time series of data of length N, not perfect but works
	#'taken from http://stats.stackexchange.com/questions/29239/creating-auto-correlated-random-values-in-r'
	#if you want all values positive set all.positive=T to rescale
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