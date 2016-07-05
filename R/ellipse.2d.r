#' @export
#' @title ellipse.2d
#' @description This function calculates a 2D kernel density then plot highest density regions with contour().
#' @param \code{x} 
#' @param \code{y} 
#' @param \code{pv} the density of the region to be outlined - defaults to 95 percent (i.e. 0.05) 
#' @param \code{sc} a scaling factor? defaults to 50
#' @references \url{https://stat.ethz.ch/pipermail/r-help/2000-March/005973.html}
#' @family  plotting
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
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


