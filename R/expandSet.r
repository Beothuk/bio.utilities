expandSet <- function(x,freq =T) {
	y = seq(min(x),max(x))
	if(freq){
		w = data.frame(y=x,f=rep(1,length(x)))
		w = aggregate(f~y,data=w,FUN=sum)
		a = data.frame(y=y)
		w = merge(w,a,all.y=T)
		w[which(is.na(w$f)),'f'] <- 0
		y= w
	}
return(y)
}