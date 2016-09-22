#' @export
#' @title dim_list
#' @description takes a list and returns a simplified list of its dimensions
#' @param \code{list1} 
#' @return \code{ab}
#' @family poorly documented
#' @author  Adam Cook, \email{Adam.Cook@@dfo-mpo.gc.ca}
#' @export
dim_list<- function(list1) {
 ab<-matrix(nrow=length(list1),ncol=2)
 for(i in 1:length(list1)) {
 
	if(!is.null(dim(list1[[i]])))	ab[i,]<-(dim(list1[[i]]))
	else ab[i,1]<-(length(list1[[i]]))
	}
	return(ab)
	}