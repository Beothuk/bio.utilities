#' @title arcinfo.shapes 
#' @description This function used to read in shapefiles for use in R
#' @seealso 
#' @note DEPRECATED!  maptools::read.shape() no longer exists

  arcinfo.shapes = function( DS, filename, shapename ) {
    .Deprecated()
    # filename = file.path( "/home", "jae", "nath", "ccpp", "cdda", "gda_012b06a_e.shp" )
    # filename = file.path(  "C:", "NATHbio", "Data", "CCPP", "Mapping", "gda_012b06a_e.shp" )
    
    shapes = file.path( dirname(filename), "ns.shapes.rdata")

    if ( DS == "arcinfo.shapefile" ) {
      library(maptools)
      ns = read.shape( filename, dbf.data=TRUE, verbose=TRUE, repair=FALSE)
      save(ns, file=shapes , compress=T)
      return ( ns )
    }

    load ( shapes )
    return ( ns )
    
  }
  


