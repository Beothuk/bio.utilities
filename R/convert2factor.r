#' @export
#' @title convert2factor
#' @description converts objects to factors
#' @note does not work in Windows
#' @param \code{x} 
#' @param \code{vars} 
#' @return \code{} 
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  convert2factor = function(x, vars) {
    for (i in vars) x[,i] = as.factor(as.character(x[,i]))
    return(x)
  }

