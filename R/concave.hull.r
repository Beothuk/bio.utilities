
  concave.hull = function( xy, k=5, ub=NULL, dname=NULL, fname=NULL, random.start=F ) {

    require(spatstat) # to compute convex hull

    if (k < 3) return (NULL)
    
    p = as.matrix( xy )
    dimnames(p) =NULL
    p = p[ ! duplicated( p) , ]

    nsets = nrow (p)
    if ( nsets < 3 ) return ( NULL )  
    if ( nsets == 3) return( p )
     
    # initiate list with the first few points 
    convex.hull <- convexhull.xy( p )
    
    p0i = which.min( convex.hull$bdry[[1]]$y )
    if (random.start) {
      p0i = floor(runif(1) * length(convex.hull$bdry[[1]]$y) ) + 1  
    }
    p.start = as.matrix( cbind( convex.hull$bdry[[1]]$x[ p0i ], convex.hull$bdry[[1]]$y[ p0i ] ) )
    hull = p0 = p.start
    to.remove = which( p0[,1] == p[,1] & p0[,2] == p[,2] )
    if (length( to.remove) > 0 ) p = p[ - to.remove ,]

    finished = F
    while ( ! finished ) {
      if (nrow(hull)==3) p = rbind( p.start, p)  # return p.start after a few steps
      p.new=NULL
      p.new = nearest.sorted.angles( p, hull, k, eps=pi/10, ub=ub ) # eps determines the acute angle solutions to ignore
      if (is.null(p.new) ) {
        kadd = k
        while (is.null(p.new) ) {
          kadd = kadd + 1
          p.new = nearest.sorted.angles( p, hull, k=kadd, eps=pi/10, ub=ub )
          if ((kadd-k) > 10) stop()
        }
      }
      if (p.new[,1] == p.start[,1] & p.new[,2] == p.start[,2]) finished = T
      p0 = p.new
      hull = rbind( hull, p0 )
      to.remove = which( p0[,1] == p[,1] & p0[,2] == p[,2] )
      if (length( to.remove) > 0 ) p = p[ - to.remove ,]
#      lines(hull[,1], hull[,2])
    }
  
    sa = signif(areapl(hull),3)
    densit = signif( nsets/areapl(hull),3)
    plot( xy, pch=20, col="gray", main=fname, 
      sub = paste("Criteria:", k, "neighbours and", ub, "km radius", "\n No. sets =", nsets, "; SA = ", sa, "km^2 \n Density = ", densit, "stations / km^2" ), 
      ylab="", xlab="" )
    lines(hull, lwd=2)
    title( )
    Pr( "pdf", dname=dname, fname=fname )

    return (hull)
  
  }


