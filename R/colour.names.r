
 
  colour.names = function( colour.order="r" ) {
    h = t( col2rgb(colors()) )
    rownames(h) = colors()
    if (colour.order=="r") i = order( h[,1], h[,2], h[,3])
    if (colour.order=="g") i = order( h[,2], h[,3], h[,1])
    if (colour.order=="b") i = order( h[,3], h[,1], h[,2])
    return( h[i,] )
  }


