dim.list<- function(list1) {
 ab<-matrix(nrow=length(list1),ncol=2)
 for(i in 1:length(list1)) {
 
	if(!is.null(dim(list1[[i]])))	ab[i,]<-(dim(list1[[i]]))
	else ab[i,1]<-(length(list1[[i]]))
	}
	return(ab)
	}