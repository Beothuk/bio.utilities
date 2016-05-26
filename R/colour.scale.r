  colour.scale = function( type="seis", nlevels=10, x=NULL, transparency=0.9 ) {
    #'
    #'     MMM - Jan, 2016: 
    #'     Was this written for R?  It almost seems like it's for 
    #'     KML?  If so, it should be documented.
    #'     
    #'     Instead of my desired scheme, i was just getting shades of pink.  
    #'     
    #'     The first line applies rbg2bgr which translates the color order and gives
    #'     the wrong colour, and then the next line attempts to add transparency 
    #'     (which does not appear to work with R).
    #'     
    #'     The end result was that instead of yellow (#FFFF00), I would get 
    #'     "e600FFFF" instead. Even if you drop the e6 (transparency) from the 
    #'     beginning, you are left with cyan (#00FFFF).
    #'         
    if (length( type) > 1 ) {
      colours = colorRampPalette( type, space = "rgb") (nlevels)
    } else {
      colours = color.code( type, n=nlevels-1 )
    }

    cols = data.frame( code=as.character(colours) ) 

    cols$code = sapply( cols$code, rbg2bgr )
    transp.hex = as.hexmode( round(transparency * 255 ) )
    cols$code = gsub( "#", transp.hex, cols$code )   
    er = range ( x, na.rm=T )
    upperbounds = seq( er[1], er[2], length.out=nlevels+1 ) [2:(nlevels+1)]
    y = findInterval( x, upperbounds ) + 1
    y[ which( y > nlevels) ] = nlevels
    return( list(y=y, cols=cols ) )
  }


