#' @export

truncate.vector = function( x, lower=-Inf, upper=Inf ) {
  #\\ truncate a vector or scalar to be bounded within a range
  .Internal( pmin( na.rm=TRUE, .Internal(pmax( na.rm=TRUE, x, lower ) ), upper ) )
}

