#' @export
geomean <- function(x){
	x = exp(mean(log(x+median(x)))))-median(x)
	return(x)
}
