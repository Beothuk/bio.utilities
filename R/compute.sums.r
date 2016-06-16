#' @title compute.sums
#' @description couldn't accurately describe
#' @param \code{x} 
#' @param \code{var} 
#' @param \code{index} 
#' @return \code{res} 
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
compute.sums = function (x, var, index) {
  res = as.data.frame.table( tapply( X=x[,var], INDEX=x[,index],
  	FUN=function(q) { sum(q, na.rm=T)}, simplify=T))
  for (i in index) { res[i,] = as.integer( res[i,] ) }
  return(res)
}

