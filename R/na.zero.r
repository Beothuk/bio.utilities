na.zero<-function(x){
  for(i in 1:length(x[1,])){
    if(length(which(is.na(x[,i])))>0){
    x[which(is.na(x[,i])),i]<-0}
    }
    return(x)
  } 