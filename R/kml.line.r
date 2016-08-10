#' @title kml.line
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.line = function( item='', name='', label='', style.id='', line.colour='4c7fffff', line.width=1, con='' ) {

    switch( item, 
      header = paste('
      <Placemark>
        <name>', name, '</name>
        <description>', label, '</description>
        <styleUrl>#', style.id, '</styleUrl>
        <LineString>
        <gx:altitudeMode>relativeToGround</gx:altitudeMode>
        <extrude>1</extrude>
        <tessellate>0</tessellate>
          <coordinates>', sep='' ), 

      footer = paste('
          </coordinates>
        </LineString>
      </Placemark>', sep='' ), 

      style = paste('
      <Style id="', style.id,'">
        <LineStyle>
			    <color>', line.colour, '</color>
		      <width>' ,line.width, '</width>
        </LineStyle>
      </Style>', sep='' )
    )
  }


