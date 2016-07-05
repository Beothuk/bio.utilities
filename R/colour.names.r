#' @export
#' @title colour.names
#' @description This function returns all of the named colours used by R with their associated R, G and B values 
#' @param \code{colour.order} = the sort order.  Valid values are \code{r}, \code{g} and \code{b} (\code{r} is the default)
#' @examples
#' color.code(type='colourblind1',n=2)
#' [1] "#FFFFD8" "#071D58"
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  colour.names = function( colour.order="r" ) {
    h = t( col2rgb(colors()) )
    rownames(h) = colors()
    if (colour.order=="r") i = order( h[,1], h[,2], h[,3])
    if (colour.order=="g") i = order( h[,2], h[,3], h[,1])
    if (colour.order=="b") i = order( h[,3], h[,1], h[,2])
    return( h[i,] )
  }


