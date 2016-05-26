#sorts all elements in a list based on the column r
sort.list.amc<-function(list1,r,inc=T) { 
	#r=column number for sort
	a<-length(list1)
	b<-list1
	for(i in 1:a) {
	ee<-list1[[i]]
	if(inc) {b[[i]]<-ee[order(ee[,r]),]}
	else {b[[i]]<-ee[rev(order(ee[,r])),]}
	}
	return(b)
}