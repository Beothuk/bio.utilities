#' @title kml.style
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.style = function( con, style.id="default", colour="ff00ffff", scale=0.5, href='' ) {
    writeLines( kml.placemark( 'style', style.id=style.id, colour=colour, scale=scale, href=href),
      con ) 
  }


