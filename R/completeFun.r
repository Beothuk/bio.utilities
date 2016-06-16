#' @title completeFun
#' @description This function removes rows where specific columns have NA
#' @param \code{data} = the matrix/data.frame to be evaluated
#' @param \code{desiredCols} = identifier for the column that must have values
#' @return \code{result} =  matrix/data.frame without rows that had \code{NA} in the \code{desiredCols}
#' @note The name is deceptive - I did not find it to be fun at all.
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @examples
#' > A = matrix(c(2, NA, 3, 1, 5, 7), nrow=2, ncol=3, byrow = TRUE)
#' > A
#' [,1] [,2] [,3]
#' [1,]    2   NA    3
#' [2,]    1    5    7
#' > completeFun(A, 2)
#' [1] 1 5 7
#' @export
completeFun <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}