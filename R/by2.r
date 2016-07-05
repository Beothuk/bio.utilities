#' @export
#' @title by2
#' @description  "slower but more flexible"
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  by2 = function (x, indices, func, var, newvars, ...) {
    x = convert2factor(x, indices)
    y = as.data.frame.table( by( data=x[,var], INDICES=x[,indices], FUN=func, ... ) )
    names(y) = c(indices, newvars)
    y = factor2character (y, indices)
    return (y)
  }


