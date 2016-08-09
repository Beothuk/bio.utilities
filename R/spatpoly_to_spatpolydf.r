#' @title spatpoly_to_spatpolydf
#' @description This function takes a spatialpolygon object and converts it to a spatialpolygondataframe (which allows it to be exported to a shapefile via writeOGR()
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
spatpoly_to_spatpolydf <- function(spat_poly)
{
  IDs <- sapply(slot(spat_poly, "polygons"), function(x) slot(x, "ID"))
  df <- data.frame(rep(0, length(IDs)), row.names=IDs)
  spat_poly_df <- SpatialPolygonsDataFrame(spat_poly, df)
  return(spat_poly_df)
}