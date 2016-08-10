#' @title kml.placemark.make
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.placemark.make = function( con, item='', name='', desc='', style.id='', colour='', scale='', href='' , x='' ) {
    if ( item=='style' ) {
      writeLines(  kml.placemark( 'style', style.id=style.id, colour=colour, scale=scale, href=href ), con ) 
    } else if ( item=='') {
      writeLines( kml.placemark( 'header', name=name, desc=desc, style.id=style.id ), con )
      writeLines( kml.coordinate( x ), con=con ) 
      writeLines( kml.placemark( 'footer' ), con )
    } 
  } 


