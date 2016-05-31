## Mapping made easy
## basic philosophy: KISS 
## use simple constructs for mapping as much as possible
## Proposed solution: use the "maps" library 
## Remember: this is to do quick and dirty plots/visualization not to do exact analyses 
##   for the latter: use "sp", "rproj", "rgdal", "lattice", etc
# Created Wednesday 11 February 2015


library(maps) 
library(mapdata)  # high resolution world coastlines/polygons  

m = map()   # low resolution map of the world .. default is rectangular coords
str(m)


# dealing with projections in a simple manner: use "mapproj"
graphics.off()
require(mapproj)
map(projection="polyconic")

graphics.off()
map(projection="albers", par=c(30,40) )

graphics.off()
map(projection="mollweide" )

graphics.off()
map("worldHires", projection="gnomonic", orient=c(0,-100,0)) # example of orient

graphics.off()
m = map("worldHires", plot=FALSE)
map("worldHires", projection='orth',orient=c(41,-74,0))
str(m)
map.grid(m, col="lightgray", label=FALSE, lty="dotted")

# to add layers to a projected map, we need to deal with projections
points(mapproject(list(y=42.5,x=-68)),col="red", pch="x", cex=3 )

# if more complex projection-based computations are required then
# use library(sp) and the function "CRS"
# as well as rgdal::project 
# .. see ecomod/spatialmethods/src/_Rfunctions/lonlat2planar.r


graphics.off()
map( "worldHires", projection="ortho", xlim=c(-165,-53), ylim=c(-0, 90 ),  )      # national boundaries
map( "worldHires", projection="azequalarea", xlim=c(-165,-53), ylim=c(-0, 90 ),  )      # national boundaries
map( "worldHires", projection="eisenlohr", xlim=c(-165,-53), ylim=c(-0, 90 ),  )      # national boundaries

  
# Canada only
graphics.off()
map( "worldHires", regions="Canada", xlim=c(-141,-53), ylim=c(40,85), col="gray90", fill=TRUE)

# oops forgot US
map( "worldHires", regions=c("USA"), resolution=0, add=TRUE )

# or both together
graphics.off()
map( "worldHires", regions=c("Canada", "USA"), xlim=c(-141,-53), ylim=c(40,85), col="gray90", fill=TRUE)


# aside .. how to extract polygons
map( "worldHires", regions=c("Canada", "USA"), xlim=c(-141,-53), ylim=c(40,85))
mCan = map( "worldHires", regions="Canada", plot=FALSE, resolution=0) 
lines( mCan,col="green" )


# zoom in and use all data
graphics.off()
map( "worldHires", regions=c("Canada", "USA"), xlim=c(-72, -56 ), ylim=c(42,49), fill=FALSE, resolution=0 )

# add some more things
map.scale()
title('Nova Scotia, High resolution')
points( -60, 44, col="red", pch=21, cex=10 )
text( -60, 44, "Sable Island" )
box()


# bring in real data
loadfunctions("groundfish")
require(lubridate)
gs = groundfish.db( "gsinf" ) 
gs = gs[ which( year( gs$timestamp) == 2010 ), ] 

# locations of sets
points( lat~lon, data=gs, col="green", pch=19, cex=0.2 )


# look at salinity in space
graphics.off()
z = gs$bottom_salinity
ncats = 100 ## number of colours
drange = range(z, na.rm=TRUE) 

loadfunctions("utility") # to get color.codes
cols = color.code( "seis", seq( drange[1], drange[2], length.out=ncats) ) [ cut( z, ncats, label = FALSE) ]  ## see color.code.r to contruct your own
zi <- rev(order( z ))
points( lat~lon, data=gs, col=cols[zi], pch=21, cex=1 )

# or to fill in the points
points( lat~lon, data=gs, bg=cols[zi], col=cols[zi], pch=21, cex=1.5 )



# zoom in and use all data .. look at temperature as bubble plots
graphics.off()
map( "worldHires", regions=c("Canada", "USA"), xlim=c(-72, -56 ), ylim=c(42,49), fill=FALSE, resolution=0 )
map.scale()
title('Nova Scotia, High resolution')


z = gs$bottom_temperature
ncats = 100 ## number of colours
drange = range(z, na.rm=TRUE) 

loadfunctions("utility") # to get color.codes
sz = seq( drange[1], drange[2], length.out=ncats) 
zcat = sz[ cut( z, ncats, label = FALSE) ]  
zi <- rev(order( z ))
points( lat~lon, data=gs, col="green", pch=21, cex=zcat[zi]/10 )

# or both colour and size of circles
cols = color.code( "seis", seq( drange[1], drange[2], length.out=ncats) ) [ cut( z, ncats, label = FALSE) ]  
points( lat~lon, data=gs,  bg=cols[zi], col=cols[zi], pch=21, cex=zcat[zi]/10 )



# or to use transparencies for temperture in this case
library(scales)  #for transparency
graphics.off()
map( "worldHires", regions=c("Canada", "USA"), xlim=c(-72, -56 ), ylim=c(42,49), fill=FALSE, resolution=0 )
map.scale()
title('Nova Scotia, High resolution')

z = gs$bottom_temperature
ncats = 100 ## number of colours
drange = range(z, na.rm=TRUE) 


loadfunctions("utility") # to get color.codes
zcat = seq( drange[1], drange[2], length.out=ncats)[ cut( z, ncats, label = FALSE) ]  
zalpha = seq( 0.1, 0.9, length.out=ncats)[ cut( z, ncats, label = FALSE) ]  
zi <- rev(order( z ))
points( lat~lon, data=gs, col="green", pchR=21, cex=zcat[zi]/10 )

# or both size of circles and transparancy 
cols = color.code( "seis", seq( drange[1], drange[2], length.out=ncats) ) [ cut( z, ncats, label = FALSE) ]  
points( lat~lon, data=gs,  bg=alpha("darkgreen", zalpha[zi] ), col=alpha("darkgreen", zalpha[zi] ), pch=21, cex=zcat[zi]/10 )


# or both size of circles and transparency and colour! :) 
cols = color.code( "seis", seq( drange[1], drange[2], length.out=ncats) ) [ cut( z, ncats, label = FALSE) ]  
points( lat~lon, data=gs,  bg=alpha(cols[zi], zalpha[zi] ), col=alpha(cols[zi], zalpha[zi] ), pch=21, cex=zcat[zi]/10 )


## to get some isobaths
graphics.off()
loadfunctions( "polygons" ) # to help search for polygon files
fn = polygon.ecomod( "isobath1000m" )  # this will not work yet until we have a storage server in place .. coming soon. .. Jae
i1000 = read.table( fn)
map( "worldHires", regions=c("Canada", "USA"), xlim=c(-72, -56 ), ylim=c(42,49), fill=FALSE, resolution=0 )
lines(i1000)

## to bring in some ARCinfo shape files:
library(maptools)  #for shapefiles .. 100 m isobath
loadfunctions( "polygons" ) # to help search for polygon files
fn = polygon.ecomod( "dm100_region" )
dm100 <- readShapePoly( fn)   # 
map( "worldHires", regions=c("Canada", "USA"), xlim=c(-72, -56 ), ylim=c(42,49), fill=FALSE, resolution=0 )
plot( dm100, add=TRUE )  # there seem to be some problems with the polygon data ... :)




### an example using lattice plots and passing the map coastline to it
# non-lattice plots do not work well inside of lattice .. but you can pass data
require(lubridate)
require(lattice)
loadfunctions( "groundfish" )
loadfunctions( "utility") 

datatoplot = groundfish.db( DS="gsinf" ) 
datatoplot$year = lubridate::year( datatoplot$timestamp ) 
datatoplot = datatoplot[ which(datatoplot$year %in% 2000:2014 ), ]
                     
# trellis.par.set(col.whitebg())
xyplot( lat ~ lon| factor(year), data=datatoplot,
  as.table=TRUE, xlab="Longitude", ylab="Latitude", main="Example",      
  panel = function(x, y, subscripts, ...) {
    panel.xyplot( x, y, pch=21, cex=0.4, col="orange" , ...)
  }
)

print(pl)

  
require(maps)
require(mapdata)
coast =  map( "worldHires", regions=c("Canada", "USA"), xlim=c(-72, -56 ), ylim=c(42,49), fill=TRUE, resolution=0, plot=FALSE)  


trellis.par.set(col.whitebg())
xyplot( lat ~ lon| factor(year), data=datatoplot, coast=coast,
  as.table=TRUE, xlab="Longitude", ylab="Latitude", main="Example",      
  panel = function(x, y, subscripts, ...) {
    panel.lines( coast$x, coast$y, col = "grey", lwd=0.7 )
    panel.xyplot( x, y, pch=21, cex=0.4, col="orange" , ...)
  }
)


           
ncats = 100
drange = range( z, na.rm=TRUE) 
cols = color.code( "seis", seq( drange[1], drange[2], length.out=ncats) ) [ cut( z, ncats, label = FALSE) ]
                
trellis.par.set(col.whitebg())
xyplot( lat ~ lon| factor(year), data=datatoplot, coast=coast, cols=cols, 
  as.table=TRUE, xlab="Longitude", ylab="Latitude", main="Example", 
  panel = function(x, y, subscripts, cols=cols, colorkey=colorkey, ...) {
    panel.lines( coast$x, coast$y, col = "grey", lwd=0.7 )
    panel.xyplot( x, y, pch=21, cex=0.4, col=cols , ...)
  }
)
  
Cairo( file="zooplankton_data_yearly.pdf", type="pdf", bg="white",  units="in", width=6, height=8 )
  print(pl)
dev.off()



