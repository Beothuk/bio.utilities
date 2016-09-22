#' @title sort_list_amc
#' @description sorts all elements in a list based on the column r
#' @param \code{r} column number for sort
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
sort_list_amc<-function(list1,r,inc=T) { 
	
	a<-length(list1)
	b<-list1
	for(i in 1:a) {
	ee<-list1[[i]]
	if(inc) {b[[i]]<-ee[order(ee[,r]),]}
	else {b[[i]]<-ee[rev(order(ee[,r])),]}
	}
	return(b)
}