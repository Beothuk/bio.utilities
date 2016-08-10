#' @title filter.dayno
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  
  filter.dayno = function( x, period, index=T ) {
    if (period=="SUMMER") {
      x = x[  x$julian > 150 & x$julian < 250 ,]
    } else if (period=="SPRING") {
      x = x[  x$julian < 149 ,]
    } else if (period=="WINTER") {
      x = x[  x$julian > 251 ,]
    } else  {
      x=x
    }
    if (index) return(i) else return(x[i,])
  }


