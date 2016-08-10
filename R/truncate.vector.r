#' @title truncate.vector
#' @description truncate a vector or scalar to be bounded within a range
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
truncate.vector = function( x, lower=-Inf, upper=Inf ) {
  .Internal( pmin( na.rm=TRUE, .Internal(pmax( na.rm=TRUE, x, lower ) ), upper ) )
}

