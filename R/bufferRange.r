bufferRange <- function(x,buffer.percent = 2) {
	#\\ adds a bit of negative a positive buffer to a range
	xr = range(x)
	if(xr[1]<0) xr[1] = xr[1]*(1+buffer.percent/100) 
	if(xr[2]<0) xr[2] = xr[2]*(1-buffer.percent/100) 
	if(xr[1]>0) xr[1] = xr[1]*(1-buffer.percent/100) 
	if(xr[2]>0) xr[2] = xr[2]*(1+buffer.percent/100) 
	return(xr)
}