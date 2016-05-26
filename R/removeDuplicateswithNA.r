#x = data.frame(trip=c(1,2,3,4,4,3),set=c(1,1,1,1,1,1),dt=c(1,2,3,4,NA,NA))

removeDuplicateswithNA = function(x,cols = c('trip','set'),idvar='dt'){
	 f = do.call(rbind,lapply(split(x,x[,cols]), function(rms) rms[which(!is.na(rms[,idvar])),]))
	 return(f)
}