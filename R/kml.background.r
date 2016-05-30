  kml.background = function( name, colour='', href='', x='' ) {
    
    paste('
		<GroundOverlay>
			<name>', name, '</name>
			<color>', colour, '</color>
			<Icon>
				<href>', href, '</href>
				<viewBoundScale>0.75</viewBoundScale>
			</Icon>
			<gx:altitudeMode>relativeToGround</gx:altitudeMode>
			<LatLonBox>
				<north>', x[1], '</north>
				<south>', x[2], '</south>
				<east>' , x[3], '</east>
				<west>',  x[4], '</west>
			</LatLonBox>
		</GroundOverlay>', sep ='' )
    }

 

