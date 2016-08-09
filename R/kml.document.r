#' @title kml.document
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export

  kml.document = function( item="", document.name="" ) {
    
    switch( item,
      header = paste(
'<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
	<name>', document.name, '</name>
', sep='' ) 
      ,
      footer = '
  </Document>
</kml>
'
    )
  }


