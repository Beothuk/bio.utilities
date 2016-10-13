#' @title offset.determine
#' @description unknown
#' @family abysmally documented
#' @author unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  offset.determine = function(x) {
    offset = median(x)
    y = x[ is.finite(x) & x>0 ]
    if( offset==0 && length(y) > 0) offset = min(y)
    return(offset)
  }


