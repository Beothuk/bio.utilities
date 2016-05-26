makePBS <- function(x,polygon=T,projection="LL") {
	cat('Polygon or Event Data for PBSmapping\n')

	if(any(names(x) %in% c('lat','lon'))) x <- rename.df(x,n0=c('lon','lat'),n1=c('X','Y'))
	if(any(names(x) %in% c('longitude','latitude'))) x <- rename.df(x,n0=c('longitude','latitude'),n1=c('X','Y'))
	if(any(names(x) %in% c('y','x'))) x <- rename.df(x,n0=c('x','y'),n1=c('X','Y'))
	if(any(names(x) %in% c('LAT','LON'))) x <- rename.df(x,n0=c('LON','LAT'),n1=c('X','Y'))
	if(any(names(x) %in% c('DDLAT','DDLON'))) x <- rename.df(x,n0=c('DDLON','DDLAT'),n1=c('X','Y'))
	
	if(polygon) {
			x$PID <- 1
			x$POS <- 1:nrow(x)
		} else {
			x$EID <- 1:nrow(x)
		}
	attr(x,'projection') <- projection
	return(x)
}
