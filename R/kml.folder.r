#' @title kml.folder
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.folder = function( item="header", folder.name='', desc='', style='', bgColor='88995419', text='' ) {
  
    switch( item,
      
      header = paste('
  <Folder>
    <name>', folder.name, '</name>
    <description>', desc, '</description>
    <styleUrl>#', style, '</styleUrl>', sep='' ) ,
      
      footer = '</Folder>',
      
      style = paste('
  <Style id="', style, '">
		<BalloonStyle>
			<text><![CDATA[', text, ']]</text>
			<bgColor>', bgColor, '</bgColor>
		</BalloonStyle>
	</Style>', sep='' ) 
    
    )
  }


