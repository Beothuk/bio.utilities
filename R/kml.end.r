#' @title kml.end
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
   kml.end = function( con ) {
    writeLines( kml.document('footer'),  con ) 
    close(con)
    print ( "Google earth file has been completed and saved" )
  }



