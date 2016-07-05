#' @export
#' @title compute.sums
#' @description This function takes a matrix, and for a given column and index, returns a matrix of different unique values for each.  
#' @param \code{x} =the input matrix
#' @param \code{var} = 
#' @param \code{index} 
#' @return \code{res} 
#' @note A = matrix(c(2, 4, 3, 1, 5, 7,2,4,7,2,5,6,1,2,3,5,6,7), ncol=3, byrow = TRUE)
#' compute.sums(A,"a",1) = for the unique values of first column, var1= corresponding value in col "a", sums of corresponding values in column a
#' compute.sums(A,"a",2) = for the unique values of second column, var1= corresponding value in col "a", Freq = sums of corresponding values in column a 
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
compute.sums = function (x, var, index) {
  res = as.data.frame.table( tapply( X=x[,var], INDEX=x[,index],
  	FUN=function(q) { sum(q, na.rm=T)}, simplify=T))
  for (i in index) { res[i,] = as.integer( res[i,] ) }
  return(res)
}

