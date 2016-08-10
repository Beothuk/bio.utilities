#' @title kml.line.make
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.line.make = function( con, item='', name='', label='', style.id='', x='', line.colour='4c7fffff', line.width=1 ) {
    
    if (item=='') {
      writeLines( kml.line( 'header', name, label, style.id ), con=con ) 
      for ( i in 1:nrow(x)) {  
        writeLines( kml.coordinate( x[i,] ), con=con ) 
      }
      writeLines( kml.line( 'footer'), con=con ) 
    }

    if (item=='style') {
      writeLines( kml.line( 'style', style.id=style.id, line.colour=line.colour, line.width=line.width), con=con )
    }
  }



