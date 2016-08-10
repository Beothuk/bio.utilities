#' @title kml.placemark
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.placemark = function( item='', name='', desc='', style.id='', colour='', scale='',
    href='' ) {
    
    href = ifelse ( href=='', 'http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png', href )

    switch( item,
      header = paste('
    <Placemark>
      <name>', name, '</name>
      <description>', desc, '</description>
      <styleUrl>#', style.id, '</styleUrl>
      <Point>
        <gx:altitudeMode>relativeToGround</gx:altitudeMode>
        <coordinates>', sep='' ) ,

      footer = paste('
        </coordinates>
      </Point>
    </Placemark>', sep='' ) ,

      style = paste('
  <Style id="', style.id, '">
		<IconStyle>
			<color>', colour, '</color>
      <scale>', scale, '</scale>
			<Icon>
				<href>', href, '</href>
			</Icon>
			<hotSpot x="0.5" y="0.5" xunits="fraction" yunits="fraction"/>
		</IconStyle>
	</Style>', sep='' )
    )  
  }
  

