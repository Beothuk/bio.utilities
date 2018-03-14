#' @title infinite2NA
#' @description converts infs to zeroes
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
infinite2NA<-function(x){
  for(i in 1:ncol(x)){
    if(length(which(!is.finite(x[,i])))>0){
    x[which(!is.finite(x[,i])),i]<-NA}
    }
    return(x)
  } 