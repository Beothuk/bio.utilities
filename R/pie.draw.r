#' @title pie.draw
#' @description couldn't accurately describe
#' @param \code{x} NULL
#' @param \code{y} NULL
#' @param \code{z} NULL
#' @param \code{radius} NULL
#' @param \code{scale} NULL
#' @param \code{labels} NULL
#' @param \code{silent} NULL
#' @family plotting
#' @note 
#' useage
#' data(landings)
#' data(coast)
#' xlim <- c(-12,-5)
#' ylim <- c(50,56)
#' xyz <- make.xyz(landings$Lon,landings$Lat,landings$LiveWeight,landings$Species)
#' col <- rainbow(5)
#' basemap(xlim, ylim, main = "Species composition of gadoid landings")
#' draw.shape(coast, col="cornsilk")
#' draw.pie(xyz$x, xyz$y, xyz$z, radius = 0.3, col=col)
#' legend.pie(-13.25,54.8,labels=c("cod","had","hke","pok","whg"), radius=0.3, bty="n", col=col,
#'  cex=0.8, label.dist=1.3)
#' legend.z <- round(max(rowSums(xyz$z,na.rm=TRUE))/10^6,0)
#' legend.bubble(-13.25,55.5,z=legend.z,round=1,maxradius=0.3,bty="n",txt.cex=0.6)
#' text(-12.25,56,"landings (kt)",cex=0.8) 
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
pie.draw <- function (x, y, z, radius, scale = T, labels = NA, silent = TRUE, 
                      ...) 
{
  nx <- length(x)
  nz <- dim(z)[2]
  if (length(y) != nx) 
    stop("x and y should be vectors of the same length")
  if (length(dim(z)) != 2) 
    stop("z should be a 2-dimensional array")
  if (dim(z)[1] != nx) 
    stop("the number of rows in of z should match as the length of x and y")
  if (sum(z, na.rm = T) == 0) 
    stop("z has no data")
  maxsumz <- max(rowSums(z), na.rm = T)
  #pm <- setProgressMsg(1, nx)
  for (i in 1:nx) {
    xi <- x[i]
    yi <- y[i]
    zi <- z[i, ]
    zi <- ifelse(is.na(zi), 0, zi)
    if (length(radius) > 1) 
      radiusi <- radius[i]
    else radiusi = radius
    if (scale & length(radius) == 1) 
      radiusi <- radius * sqrt(sum(zi, na.rm = T))/sqrt(maxsumz)
    if (sum(zi) > 0) 
      pie.add(zi, xi, yi, labels, radius = radiusi, ...)
    if (!silent) 
      iw=11
    #pm <- progressMsg(pm, i)
  }
}