#' @export
#' @title blue.red
#' @description This function generates a vector of shades from blue to red of a length selected by value of \code{n}.
#' @param \code{n} = the number of colors desired
#' @return character vector
#' @examples
#' blue.red(5)
#' [1] "#0000FF" "#FFFFFF" "#FFFFFF" "#FF0000"
#' @note As of 2016-06-14, this function generates an error: unused argument (gamma = gamma).  It appears to be attempting to generate a hsv value by adding a gamma value at the end of a hex value.  Removing \code{, gamma=gamma} generates the expected ramp.
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
blue.red <- function (n) 
  { 
    n = n-2
    if ((n <- as.integer(n[1])) > 0) { 
      even.n <- n%%2 == 0
      green = 2/6
      red = 0
      blue = 4/6
      gamma = 1.6
      k <- n%/%2
      l1 <- k + 1 - even.n
      l2 <- n - k + even.n
      c( if (l1 > 0) {
            hsv( h = blue, 
                 s = seq(1, ifelse(even.n, 1/k, 0), length = l1), 
                 v = 1)
          },
         if (l2 > 1) { 
           hsv( h = red, 
                s = seq(0, 1, length = l2), 
                v = 1, 
                gamma=gamma)
         } 
       )
    }
  }
  

