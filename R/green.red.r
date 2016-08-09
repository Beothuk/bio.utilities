#' @title green.red
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  green.red <- function (n) {
    # the default colour scheme ... note additional ones can be passed .. check the main prg
    colour = NA
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
      colour = c( 
          if (l1 > 0) { hsv( h=green, s=seq(1, ifelse(even.n, 1/k, 0), length=l1), v=1) }, 
          if (l2 > 1) { hsv( h=red, s=seq(0, 1, length=l2), v=1) } 
      )
    }
    return( colour )
  }


