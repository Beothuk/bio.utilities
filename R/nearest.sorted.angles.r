#' @title nearest.sorted.angles
#' @description unknown
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  nearest.sorted.angles = function( plist, hull, k, eps=pi/4, ub=NULL ) {
 
    nch = nrow(hull) 
    pfocus = t(hull[nch,])  # the focal point

    pfocus.prev.i = nch - 1 
    if (pfocus.prev.i < 1) pfocus.prev.i = 1
    p.last = t(hull[pfocus.prev.i,])  # the point prior to focal point
    
    distance = sqrt( (pfocus[,1]- plist[,1])^2 + (pfocus[,2]- plist[,2])^2 )

    too.close = which( distance < eps)
    if (is.null(ub)) ub = max(distance)
    inrange =  which( distance < ub )
    closest.n = order(distance)[1:k]
    keep = unique( union( inrange, closest.n ) )
    keep = setdiff( keep, too.close )

    pout = plist[ keep, ]

    # pfocus is the origin: calc delta's relative to pfocus,
     dpx = pout[,1] - pfocus[,1]    # (delta x, delta y)
     dpy = pout[,2] - pfocus[,2]    # (delta x, delta y)

     d0x =  p.last[,1] - pfocus[,1]
     d0y =  p.last[,2] - pfocus[,2]   # pfocus is the focal point 
  
    an0 = atan2(d0y, d0x)
    if (an0<0) an0 = 2*pi + an0 
   
    angles = atan2(dpy, dpx) 
    ww = which(angles<0)
    if (length(ww)>=1) angles[ ww ] = 2*pi + angles[ ww ] 

    angles =  angles - an0 - eps
    xx = which(angles<0)
    if (length(xx)>=1) angles [ xx ] = 2*pi + angles[ xx ] 
     
    i.angles = order( angles, decreasing=F )
    angles = angles[ i.angles ]
    pout = as.matrix( pout[ i.angles ,] )

debug=F
if (debug) {
  print (angles)
  a = rbind(pfocus, pout)
  plot(xy)
  angles = c(0, angles)
  col="black"
  for (i in 1:(nrow(pout)+1)) text( a[i,1], a[i,2], paste(i, signif(angles[i],2), sep="="),col="green", adj=1 )
}
    
   p.int = test.intersection( pfocus, hull, p.test=pout )     # first non-intersecting point 
   #p.int = as.matrix(t(pout[1,]))

   return (p.int)
  }


