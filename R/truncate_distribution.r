#' @title truncate_distribution
#' @description the following truncates data to a range limited by quantiles or fixed limits
#' @param \code{W} NULL
#' @param \code{Ql} NULL
#' @param \code{Qu} NULL
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
truncate_distribution = function( W, Ql, Qu ) {
        Q = quantile( W, c(Ql, Qu), na.rm=T )
        j = which( W < Q[1] )
        k = which( W > Q[2] )
        if (length( j)>0 ) W[j] = Q[1]
        if (length( k)>0 ) W[k] = Q[2]
        return (W)
      }

