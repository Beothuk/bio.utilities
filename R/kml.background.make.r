#' @title kml.background.make
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.background.make = function( con, name, colour='', href='', x='' ) {
    writeLines( kml.background( name=name, colour=colour, href=href, x=x ), con )
  }



