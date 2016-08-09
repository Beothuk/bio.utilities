#' @title kml.polygon.make
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.polygon.make = function( con, item='', name='', label='', style.id='', x='', colour='ff0000cc', line.colour='4c7fffff', line.width='1', fill='0', outline='1', style.id.normal='', style.id.highlight=''  ) {
    
    if (item=='') {
      writeLines( kml.polygon( 'header', name, label, style.id ), con=con ) 
      for ( i in 1:nrow(x)) {  
        writeLines( kml.coordinate( x[i,] ), con=con ) 
      }
      writeLines( kml.polygon( 'footer'), con=con ) 
    }

    if (item=='style') {
      writeLines( kml.polygon( 'style', style.id=style.id, colour=colour, line.colour=line.colour, line.width=line.width, fill=fill, outline=outline), con=con )
    }

    if (item=='stylemap') {
      writeLines( kml.polygon( 'stylemap', style.id=style.id, style.id.normal=style.id.normal, style.id.highlight=style.id.highlight), con=con )
    }


  }


