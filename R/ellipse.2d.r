

ellipse.2d = function( x, y, pv=0.05, sc=50 ) {
  library(KernSmooth)
  xr = range( x, na.rm=T)
  yr = range( y, na.rm=T)
  dx = (xr[2] - xr[1] ) / sc
  dy = (yr[2] - yr[1] ) / sc
  z = bkde2D(cbind(x,y), bandwidth=c(dx,dy))
  zsort <- sort(z$fhat)
  p <- cumsum(zsort)/sum(zsort)
  contour(z$x1, z$x2, z$fhat, levels=min(zsort[p>=pv]), add=T, labels="", drawlabels=F )
  # points(x,y, pch=20) 
}


