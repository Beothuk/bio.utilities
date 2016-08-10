#' @title rm.from.list
#' @description removes elements from list that contain no information
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
rm.from.list<-function(list1) {
	a<-dim.list(list1)
	if(any(a[,1]==0)) {
	list1<-list1[-which(a[,1]==0)]
		}
	return(list1)
	}