#' @title kml.start
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
 kml.start = function( outfile, document.name ) {
    if ( file.exists(outfile) ) file.remove( outfile)
    con = file( outfile, open="a") 
    writeLines( kml.document('header', document.name),  con ) 
    return(con)
  }
 

