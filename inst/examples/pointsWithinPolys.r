#MMM - Oct 2, 2014
##Example of using ecomod to accomplish something useful
##Getting point data, and checking if it is in a particular polygon

#requires gstat, sp package
loadfunctions("utility")
loadfunctions("polygons")

#find and load a point dataset
#rename the fields to lat and lon (unnecessary)
#multiply longitudes by -1, since this data was in the wrong hemisphere

pointfile <- read.csv(file.path(find.ecomod.gis("surveypoints")))
pointfile<-rename.df(pointfile, "Lat.Start","lat")
pointfile<-rename.df(pointfile, "Long.Start","lon")
pointfile$lon<-pointfile$lon*-1

#find and load a polygon (4vw, in this case)
#rename the fields to lat and lon (unnecessary)
this.poly<-read.table(find.ecomod.gis("nafo.4vw.dat"))
this.poly<-rename.df(this.poly, "V1","lon")
this.poly<-rename.df(this.poly, "V2","lat")

#send the coordinates to the point.in.polygon function (sp package) to return array 
#of whether the points are:
# (0) of the polygon
# (1) in the polygon
# (3) relative interior of an edge of the polygon
# (4) coincident with a vertex of the polygon
#appends these values to the pointfile data
library("sp")
pointstatus<-point.in.polygon(pointfile$lon,pointfile$lat,this.poly$lon,this.poly$lat)
pointfile<-cbind(pointfile,pointstatus)

#adds text to a new field of the pointfile depending on where the point lay
pointfile$area<-ifelse(pointfile$pointstatus==0,"outside",
                       ifelse(pointfile$pointstatus==1,"inside",
                              ifelse(pointfile$pointstatus==2,"relative interior of an edge","vertex")))

write.csv(pointfile,"pointfile.csv")
