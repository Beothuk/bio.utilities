#' @export
#' @title concave.hull
#' @description Find the outline (boundary) of a set of points in 2D space.
#' @param \code{xy}  Points data in x,y format
#' @param \code{k} Number of nearest neighbours to consider, defaults to 5
#' @param \code{ub} Upper bound in spatial distance to consider, defaults to 1/8 max range
#' @param \code{plot} defaults to TRUE
#' @param \code{random.start} defaults to FALSE otherwise the min values are used.
#' @family documented
#' @author Jae Choi, \email{<jae.choi>@dfo-mpo.gc.ca}
#' @export
  concave.hull = function( xy, k=5, ub=NULL, plot=FALSE, random.start=FALSE ) {

    if (k < 3) return (NULL)
    p = as.matrix( xy )
    dimnames(p) =NULL
    p = p[ ! duplicated( p) , ]
    if (is.null(ub)) {
      dx = diff(range(xy[,1]))
      dy = diff(range(xy[,2]))
      dd = max( dx, dy )
      ub = dd / 8
    }

    nsets = nrow (p)
    if ( nsets < 3 ) return ( NULL )
    if ( nsets == 3) return( p )

    # initiate list with the first few points
    convex.hull <- spatstat::convexhull.xy( p )

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
      p.new = bio.utilities::nearest.sorted.angles( p, hull, k, eps=pi/10, ub=ub ) # eps determines the acute angle solutions to ignore
      if (is.null(p.new) ) {
        kadd = k
        while (is.null(p.new) ) {
          kadd = kadd + 1
          p.new = bio.utilities::nearest.sorted.angles( p, hull, k=kadd, eps=pi/10, ub=ub )
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

    sa = signif(splancs::areapl(hull),3)
    densit = signif( nsets/splancs::areapl(hull),3)

    print( paste("Surface area:", sa))
    print( paste("Mean density:", densit))
    print( paste("Neighbourhood radius:", ub))
    print( "Check the plot and modify ub to alter the complexity of the outline." )

    if (plot) {
      plot( xy, pch=20, col="gray",
        sub = paste("Criteria:", k, "neighbours and", ub, "km radius", "\n No. sets =", nsets, "; SA = ", sa, "km^2 \n Density = ", densit, "stations / km^2" ),
        ylab="", xlab="" )
      lines(hull, lwd=2)
    }

    return (hull)
  }


