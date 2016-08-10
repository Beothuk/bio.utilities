#' @title kml.folder.start
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.folder.start = function ( con, folder.name='', desc='', style='' ) {
    writeLines( kml.folder( 'header', folder.name, desc ), con )
   }
  
 
