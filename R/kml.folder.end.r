#' @title kml.folder.end
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
 kml.folder.end = function ( con ) {
    writeLines( kml.folder( 'footer' ), con )
  }


