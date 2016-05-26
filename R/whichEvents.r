whichEvents <- function(lonlatpoint,radius,event.data,on.boundary=T) {
	#lonlatpoint is the central data point you want to find the surroundings c(lon,lat)
	#radius is the radius of the buffer zone you want to identify
	#event.data is the data frame for finding the points within a specified radius
	#on.boundary if true will include all points on the boundry of the polygon
	loadPackages(PBSmapping)
	
	poly <- makePBS(bufferCircle(lonlat=lonlatpoint,radius=radius),polygon=T)
	e <- makePBS(event.data,polygon=F)
	e <- e[e$EID %in% findPolys(e,poly)[,1],]
	
	oo <- list(lonlatpoint,radius,poly,EventsinPolygon=e)
	
	return(oo)
}