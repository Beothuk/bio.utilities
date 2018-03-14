stdize <- function(x) {                                                                                   
    y <- (x-mean(x,na.rm=T))/sd(x,na.rm=T)                                                                                
    return(y)                                                                                             
  }  