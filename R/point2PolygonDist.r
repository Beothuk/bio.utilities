#' @title point2PolygonDist
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
point2PolygonDist <- function(poly, pt){
	require(PBSmapping)
	attr(poly,'projection') <-"LL"
	attr(pt,'projection') <-"LL"
	attr(poly,'zone') <- 20
	attr(pt,'zone') <- 20
	poly	= convUL(poly)
	pt 		= convUL(pt)
	pp <-  dist2Line(pt[,c('X','Y')],poly[,c('X','Y')])
	pt$dist <- pp[,1]/1000
	pt <- convUL(pt)
return(pt)
}