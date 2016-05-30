
   kml.end = function( con ) {
    writeLines( kml.document('footer'),  con ) 
    close(con)
    print ( "Google earth file has been completed and saved" )
  }



