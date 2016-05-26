cbindPad <- function(x,y) {
	#add in NAs to fill in missing rows for combining multiple data sources
	
	if(!is.vector(x)) {
	xx <- nrow(x)
	xy <- ncol(x)
	yy <- length(y)
	w <- matrix(NA,nrow=max(c(xx,yy)),ncol=xy+1)
	w[1:xx,1:xy] <- as.matrix(x)
	w[1:yy,(xy+1)] <- y
	return(w)
	} else {
	xx <- length(x)
	yy <- length(y)
	f <- which.max(c(xx,yy))
	if(f==1) y <- c(y,rep(NA,xx-yy))
	if(f==2) x <- c(x,rep(NA,yy-xx))
	w <- cbind(x,y)
	return(w)
	}
	
}