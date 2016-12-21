#' @export
#' @title create_random_matrix
#' @description This function calculates depth in meters from pressure in decibars using Saunders and Fofonoff's method
#' @param \code{the.nrow} = desired number of rows (default is 5)
#' @param \code{the.ncol} = desired number of columns (default is 5)
#' @param \code{the.range} = the range of values to use (default is 1:100)
#' @return matrix of integers with the specified dimensions
#' @author  Mike McMahon, \email{Mike.McMahon@@dfo-mpo.gc.ca}
#' @family random data
#' @examples create.random.matrix(the.nrow=10, the.ncol=20, the.range=0:9)
#' @export
create_random_matrix<-function(the.nrow=10, the.ncol=2, the.range=1:50){
  return(matrix(sample(the.range, size = the.nrow*the.ncol, replace = TRUE), the.nrow, the.ncol))
}