geomean <- function(x){
	x = exp(mean(log(x+min(x[x>0]))))-min(x[x>0])
	return(x)
}
