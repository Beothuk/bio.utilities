#' @title kml.screen.overlay
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.screen.overlay = function( name, color='ffffffff', href='', 
    overlay=c(0,1,"fraction","fraction"), screen=c(5,5,"pixel","pixelinset"), size=c(100,100,"pixel","pixel")  ) {

    paste('
    <ScreenOverlay>
      <name>', name, '</name>
      <color>', color, '</color>
      <visibility>1</visibility>
      <Icon>
        <href>', href, '</href>
      </Icon>
          <overlayXY x="', overlay[1], '" y="', overlay[2], '" xunits="', overlay[3], '" yunits="', overlay[4], '"/>
          <screenXY x="', screen[1], '" y="', screen[2], '" xunits="', screen[3], '" yunits="', screen[4], '"/>
          <size x="', size[1], '" y="', size[2], '" xunits="', size[3], '" yunits="', size[4], '"/>
    </ScreenOverlay>',  sep ='' )
  }
   

