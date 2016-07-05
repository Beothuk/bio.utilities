#' @export
#' @title bio.blue
#' @description This function generates a vector of shades of blue (from white to blue) of the length selected by value of \code{n}.
#' @param \code{n} = the number of colors desired
#' @param \code{alpha} = the transparency desired (default is fully opaque/1)
#' @return character vector
#' @examples
#' bio.blue(5)
#' [1] "#FFFFFFFF" "#AAAAFFFF" "#5555FFFF" "#0000FFFF"
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
bio.blue <- function (n, alpha=1) { 
    if ((n <- as.integer(n[1])) > 0) { 
      blue = 4/6
      c( hsv( h = blue, 
              s = seq(0, 1, length = (n-1)), 
              v = 1, 
              alpha = alpha )
       ) 
    }
  }
   

