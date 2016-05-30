 kml.start = function( outfile, document.name ) {
    if ( file.exists(outfile) ) file.remove( outfile)
    con = file( outfile, open="a") 
    writeLines( kml.document('header', document.name),  con ) 
    return(con)
  }
 

