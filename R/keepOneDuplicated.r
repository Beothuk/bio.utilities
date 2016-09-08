#' @title keepOneDuplicated
#' @description unknown
#' @param \code{x} the data frame containing all data, 
#' @param \code{cols} is the columns to check for duplicates, 
#' @param \code{test.col} is the column which contains the info that is not duplicated and you wish to remove one entry based on a test.val and a test.direction
#' @param \code{test.val} NULL
#' @param \code{test.direction} NULL
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
#' 
keepOneDuplicated = function(x,cols,test.col,test.val,test.direction=c('greater','less','equal','not.equal')) {

	a = which(duplicated(x[,cols],fromLast=F))
	b = which(duplicated(x[,cols],fromLast=T))
    p = c(a,b)
	y = x[p,]
	
	if(test.direction == 'greater') y = y[which(y[test.col]>test.val),]
	if(test.direction == 'less') y = y[which(y[test.col]<test.val),]
	if(test.direction == 'equal') y = y[which(y[test.col]==test.val),]
	if(test.direction == 'not.equal') y = y[which(y[test.col]!=test.val),]
	                
	yy = x[-p,]
	xx = rbind(y,yy)
	return(xx)
	}