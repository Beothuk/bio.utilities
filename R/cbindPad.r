#' @export
#' @title cbindPad
#' @description This function adds in NAs to fill in missing rows for combining multiple data sources
#' @param \code{x} = vector, matrix
#' @param \code{y} = vector or matrix to join to \code{x}
#' @return  \code{w}
#' @examples
#' A = matrix(c(2, 4, 3, 1, 5, 7), nrow=2, ncol=3, byrow = TRUE)
#' B = matrix(c(1, 5, 7), nrow=3, ncol=1, byrow = TRUE)
#' cbindPad(A,B)
#' [,1] [,2] [,3] [,4]
#' [1,]    2    4    3    1
#' [2,]    1    5    7    5
#' [3,]   NA   NA   NA    7
#' 
#' C=c(1,2,3,4,5)
#' D=c(6,7,8,9,10,11,12,13,14,15)
#' cbindPad(C,D)
#' x  y
#' [1,]  1  6
#' [2,]  2  7
#' [3,]  3  8
#' [4,]  4  9
#' [5,]  5 10
#' [6,] NA 11
#' [7,] NA 12
#' [8,] NA 13
#' [9,] NA 14
#' [10,] NA 15
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
cbindPad <- function(x,y) {
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