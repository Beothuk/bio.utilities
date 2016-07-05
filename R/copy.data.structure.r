#' @export
#' @title copy.data.structure
#' @description takes an exiting data frame, and returns the structure only
#' @param \code{x} the source data.frame
#' @return \code{y} the empty data.frame 
#' @examples
#' n = c(2, 3, 5) 
#' s = c("aa", "bb", "cc") 
#' b = c(TRUE, FALSE, TRUE) 
#' df = data.frame(n, s, b) 
#' str(copy.data.structure(df))
#' 'data.frame':	0 obs. of  3 variables:
#' $ n: num 
#' $ s: chr 
#' $ b: logi 
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @note MMM - 2016-06-16 - a note in the script says 'there must be an easier way of doing this ?' and there is:
#' y=x[0,] - this gets the zero'th row
#' @export
  copy.data.structure =function( x) {
    if (class(x) == "data.frame") {
      y = x[ 1, ]
      y = y[-1, ]
      return (y)
    }
  }

