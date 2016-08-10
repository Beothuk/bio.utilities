#' @title simulateMixtures
#' @description Simulate Mixtures
#' @param \code{k} is the number of clusters
#' @param \code{means} is the median for each cluster
#' @param \code{sigma} is the standard deviation for each cluster
#' @param \code{prop} is the proportion of the total sample reprensent by each density normalized to one 
#' @param \code{size} is the length of the output vector
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
simulateMixtures <- function(k,means,sigmas,prop=NA,size=10000) {
	if(length(means)!=length(sigmas) | length(means) !=k | length(sigmas)!=k) stop('Vector lengths for means,sigmas and props need to match the number of clusters (k)')
			if(any(is.na(prop))) prop <- rep(1/k,length.out=k)
			prop 	<- 	prop/(sum(prop))
			n 		<- 	prop * size
			
			v <- c()
			
			for(i in 1:k) {
				 	w <- rnorm(n[i],means[i],sigmas[i])	
					v <- c(v,w)
			}
							
			return(v)
	}
