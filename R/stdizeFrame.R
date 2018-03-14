#' @export
stdizeFrame <- function(x) {
	nx <- ncol(x)
	m = 0 
	uI <- unique(x$ID)
for(i in 3:nx) {
		m=m+1
	for(j in 1:length(uI)) {
		x[x$ID==uI[j],m+nx] <- stdize(x[x$ID==uI[j],i])
		}
	names(x)[m+nx] <- paste(names(x)[i],"_s",sep="")
	}
	return(x)
}