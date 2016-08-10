#' @export
#' @title bufferRange
#' @description This function adds a bit of negative a positive buffer to a range.
#' @param \code{buffer.percent} = buffer amount (default = 2) 
#' @return 2 values, each buffered to extend the range by the selected percentage
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @examples
#' x=-1000:10   
#' bufferRange(x,2)
#' [1] -1020.0    10.2
#' @export
bufferRange <- function(x,buffer.percent = 2) {
	xr = range(x)
	if(xr[1]<0) xr[1] = xr[1]*(1+buffer.percent/100) 
	if(xr[2]<0) xr[2] = xr[2]*(1-buffer.percent/100) 
	if(xr[1]>0) xr[1] = xr[1]*(1-buffer.percent/100) 
	if(xr[2]>0) xr[2] = xr[2]*(1+buffer.percent/100) 
	return(xr)
}