rm.from.list<-function(list1) {
	#removes elements from list that contain no information
	a<-dim.list(list1)
	if(any(a[,1]==0)) {
	list1<-list1[-which(a[,1]==0)]
		}
	return(list1)
	}