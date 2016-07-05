#' @export
#' @title colour.scale
#' @description This functions return a vector of length \code{x} KML (Google Earth) colour codes using a pre-defined palettes ('seis'). 
#' @param \code{type} = default is \code{seis}
#' @param \code{nlevels} = the number of unique colours to generate (default is 10)
#' @param \code{x} = a vector
#' @param \code{transparency} = the transparency of the resultant colours (default is 0.9)
#' @return list of 2: \code{$y} is a vector of \code{x-1} length, which can used to assign the colours of \code{$cols} to the original vector \code{x}; \code{$cols} is a vector of KML colours of length \code{nlevels}
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @examples
#' colour.scale(nlevels=3,x=seq(1:6))
#' $y
#' [1] 1 1 2 2 3 3
#' 
#' $cols
#' code
#' 1 e68B0000
#' 2 e600008B
#' @note not totally sure if this function works as intended.  It seems as though \code{nlevels} should return the number of colours specified - not one less.  Jae or Adam might have more information about this.
#' @export
colour.scale = function( type="seis", nlevels=10, x=NULL, transparency=0.9 ) {
    # if (length( type) > 1 ) {
    #   colours = colorRampPalette( type, space = "rgb") (nlevels)
    # } else {
      colours = color.code( type, n=nlevels-1 )
    # }

    cols = data.frame( code=as.character(colours) ) 

    cols$code = sapply( cols$code, rbg2bgr )
    transp.hex = as.hexmode( round(transparency * 255 ) )
    cols$code = gsub( "#", transp.hex, cols$code )   
    er = range ( x, na.rm=T )
    upperbounds = seq( er[1], er[2], length.out=nlevels+1 ) [2:(nlevels+1)]
    y = findInterval( x, upperbounds ) + 1
    y[ which( y > nlevels) ] = nlevels
    return( list(y=y, cols=cols ) )
  }


