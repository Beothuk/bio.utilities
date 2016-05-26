
jackknifeCPUE<-function(data,err='se',grouping){
	#Smith 1980 CJFAS
	#grouping = c('month','year')
	#data must contain catch and effort columns
	if(!all(c('catch','effort') %in% names(data))) stop('Data frame must contain columns named catch and effort')
	a = Sys.time()
		data$grp = data[,grouping]
		if(length(grouping)>1) data$grp = apply( data[,grouping] , 1 , paste , collapse = "." )
		data$n = 1
		Cf<-aggregate(cbind(catch,effort,n)~grp,data=data,FUN=sum)
		Cf$Cf<-with(Cf,catch/effort)
		ng = length(grouping)
		ap = as.data.frame(matrix(NA,ncol=ng,nrow=nrow(Cf)))
		names(ap) = grouping
		out.dat<-cbind(data.frame(Cf,cpue=NA,cpue.var=NA),ap)
		nc = ncol(out.dat)
	for (i in 1:nrow(out.dat)){
		io = out.dat[i,]
		dp = data[which(data$grp==io$grp),]
		iu = unlist(strsplit(io$grp,"[.]"))
		iun = length(iu)
		out.dat[i,(nc-(iun-1)):nc] <- iu	
	if(io$n>1){
			Rj<-c()
			for (j in 1:io$n){
				Rj[j]<-io$n * io$Cf - (io$n-1)*(sum(dp$catch[-j])/sum(dp$effort[-j]))
			}
				
			out.dat$cpue[i]<-mean(Rj)
		if(err=='sd')out.dat$cpue.var[i]<-var(Rj)
		if(err=='se')out.dat$cpue.var[i]<-1/(io$n*(io$n-1))*sum((Rj-mean(Rj))^2)
		}
	}
	out.dat$grp = NULL
	return(out.dat)
	}
	
	
	
	
	
	
	
	
