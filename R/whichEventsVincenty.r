whichEventsVincenty <- function(lonlat,events,radius) {
		cat('Uses Vincenty Formula to Determine Distances between points \n')
		cat('radius is in km \n')
		
		if(length(which((names(events) %in% c('lon','lat'))))!=2) {
			cat('events need to be a data.frame and must contain columns named c(lon,lat)\n')
			stop()
			}
		
		po	 	 <- data.frame(lon=lonlat[1],lat=lonlat[2])
		events$D <- vincenty(loc1=po,loc2=events,a=6378.13700, f= 1/298.257223563)
		return(events[which(events$D<radius),])
		}