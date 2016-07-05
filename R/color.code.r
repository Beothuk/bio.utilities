#' @export
#' @title color.code
#' @description This functions return a vector of colour codes using a number of pre-defined palettes ('types') 
#' @param \code{type} = the colour palette to use.  Valid options include: yellow.red; blue.black; red.white.blue; seis; red.yellow.blue; nathalie; blue.yellow.red; blue.yellow.blue; colourblind1
#' @param \code{n} = the number of colours to return
#' @return vector of \code{n} length of hex color codes
#' @examples
#' color.code(type='colourblind1',n=2)
#' [1] "#FFFFD8" "#071D58"
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  color.code = function( type="seis", n ) {
    # R create RGB colours 
    cols = switch( type,
      yellow.red = colorRampPalette(c("white","yellow","orange","red","darkred", "black"), space = "Lab") ,
      blue.black = colorRampPalette(c("darkblue","cyan","green", "yellow", "orange","darkred", "black"), space = "Lab"),
      red.white.blue = colorRampPalette(c("red", "white","blue"), space = "Lab"),
      seis = colorRampPalette(c("darkblue","blue3", "green", "yellow", "orange","red3", "darkred"), space = "Lab"), 
      red.yellow.blue =  colorRampPalette(c("blue", "green", "yellow", "orange","red"), space = "Lab"), 
      nathalie = colorRampPalette( c("#d62f27", "#ed7a53", "#fccc95", "#dee3bf" , "#91a8ba", "#4575b5" ), space="Lab"),
      blue.yellow.red =  colorRampPalette(c("blue", "green", "yellow", "orange","red"), space = "Lab"), 
      blue.yellow.blue =  colorRampPalette(c("blue",  "green", "yellow", "gold", "royalblue", "blue"), space = "Lab"), 
      colourblind1 =  colorRampPalette(c("#ffffd9","#edf8b1","#c7e9b4","#7fcdbb","#41b6c4","#1d91c0","#225ea8","#253494","#081d58"), space = "Lab") 
          )
    if (length(n)==1) {
      val = cols( n )
    } else {
      val = cols( length(n) + 1 )
    }

    return ( val )
  }


