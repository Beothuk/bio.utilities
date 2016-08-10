#' @title kml.polygon
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.polygon = function( item='', name='', label='', style.id='', colour='ff0000cc', line.colour='4c7fffff', line.width="1", fill="0", outline="1", con='', style.id.highlight='', style.id.normal='' ) {

    switch( item, 
      header = paste('
      <Placemark>
        <name>', name, '</name>
        <description>', label, '</description>
        <styleUrl>#', style.id, '</styleUrl>
        <Polygon>
        <gx:altitudeMode>relativeToGround</gx:altitudeMode>
        <tessellate>1</tessellate>
        <outerBoundaryIs>
          <LinearRing>
            <coordinates>', sep='' ), 

      footer = paste('
            </coordinates>
        </LinearRing>
        </outerBoundaryIs>
        </Polygon>
      </Placemark>', sep='' ), 

      style = paste('
      <Style id="', style.id,'">
        <LineStyle>
			    <color>', line.colour, '</color>
		      <width>' ,line.width, '</width>
        </LineStyle>
        <PolyStyle>
          <color>', colour, '</color>
          <fill>', fill, '</fill> 
          <outline>', outline, '</outline>
        </PolyStyle>
      </Style>', sep='' ),

      stylemap = paste('
      <StyleMap id="', style.id, '">
        <Pair>
          <key>normal</key>
          <styleUrl>#', style.id.normal, '</styleUrl>
        </Pair>
        <Pair>
          <key>highlight</key>
          <styleUrl>#', style.id.highlight, '</styleUrl>
        </Pair>
      </StyleMap>', sep='')
    
    )
  }



