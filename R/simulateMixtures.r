#' @export
#simulate mixtures

simulateMixtures <- function(k,means,sigmas,prop=NA,size=10000) {
	#k is the number of clusters
	#means is the median for each cluster
	#sigma is the standard deviation for each cluster
	#prop is the proportion of the total sample reprensent by each density normalized to one 
	#size is the length of the output vector
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
