spatpoly_to_spatpolydf <- function(spat_poly)
{
  #'MMM March 2016
  #'This function takes a spatialpolygon object and converts it to a 
  #'spatialpolygondataframe (which allows it to be exported to a shapefile via 
  #'writeOGR()
  IDs <- sapply(slot(spat_poly, "polygons"), function(x) slot(x, "ID"))
  df <- data.frame(rep(0, length(IDs)), row.names=IDs)
  spat_poly_df <- SpatialPolygonsDataFrame(spat_poly, df)
  return(spat_poly_df)
}