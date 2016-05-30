
  kml.style = function( con, style.id="default", colour="ff00ffff", scale=0.5, href='' ) {
    writeLines( kml.placemark( 'style', style.id=style.id, colour=colour, scale=scale, href=href),
      con ) 
  }


