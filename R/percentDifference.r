#' @title percentDifference
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
percentDifference <- function(x) {
	 
	if(is.vector(x)) {
		n <- length(x)
	        x <- x[order(x)]
	        v <- (x[2:n]-x[1:n-1])/((x[2:n]+x[1:n-1])/2)*100
        	
	} else {
		v <- (x[,1] - x[,2]) / ((x[,1]+x[,2])/2) * 100
}
        	return(v)

}
