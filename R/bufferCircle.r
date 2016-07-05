#' @export
#' @title bufferCircle
#' @description This function buffers a point by a specified radius \code{n}. 
#' @param \code{lonlat} = the position to buffer 
#' @param \code{radius} = the radius in kilometers to buffer
#' @param \code{npoints} = number of discrete points to create (default is 100)
#' @return data.frame of 101 indivual points of $lat and $lon
#' @examples
#' bufferCircle(c(-64.15,44.75),100)
#' @author  Adam Cook, \email{Adam.Cook@@dfo-mpo.gc.ca}
#' @export
bufferCircle <- function(lonlat, radius, npoints=100) {
	#//**radius must be in km, this treats the globe as a sphere**
	     
		 Rearth <- 6378.137 
	     Dd <- rep(radius / Rearth,npoints+1)
	     
	     Cc <- seq(0, 2*pi, by=2*pi/npoints) #turning direction
	
	         lata <- lonlat[2] * (pi/180) #convert to radians
	         lona <- lonlat[1] * (pi/180)
	
	     latb <- asin(cos(Cc) * cos(lata) * sin(Dd) + sin(lata) * cos(Dd))
	     dlon <- atan2(cos(Dd) - sin(lata) * sin(latb), sin(Cc) * sin(Dd) * cos(lata))
	     lonb <- lona - dlon + pi/2
	
	     lonb[lonb >  pi] <- lonb[lonb >  pi] - 2 * pi
	     lonb[lonb < -pi] <- lonb[lonb < -pi] + 2 * pi
	
	     latb <- latb * (180 / pi) #back to lat lon
	     lonb <- lonb * (180 / pi)
	
	     out <- data.frame(lon = lonb, lat = latb) 
	     return(out)
     }

