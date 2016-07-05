#' @export
#' @title duplicates.toremove
#' @description This function looks for rows that contain identical values as other rows, irrespective of position  
#' @param \code{m}  The matrix to examine
#' @return the indices of values that have duplicates
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @examples duplicates.toremove(c(1,2,3,4,5))
#' integer(0)
#' duplicates.toremove(c(1,1,3,4,5))
#' [1] 1 2
#'
#' m
#' [,1] [,2] [,3]
#' [1,]    2    3    3
#' [2,]    2    1    2
#' [3,]    3    3    2
#' [4,]    2    1    1
#' [5,]    2    1    2
#' #duplicates.toremove(m)
#' [1]  1  2  4  5 12 13 15
#' @export
  duplicates.toremove = function(x) {
    e = NULL
    d = which(duplicated(x))
    e = which(x %in% x[d])
    return(e)
  }

