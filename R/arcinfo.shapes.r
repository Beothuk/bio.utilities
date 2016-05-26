
  arcinfo.shapes = function( DS, filename, shapename ) {
    
    # filename = file.path( "/home", "jae", "nath", "ccpp", "cdda", "gda_012b06a_e.shp" )
    # filename = file.path(  "C:", "NATHecomod", "Data", "CCPP", "Mapping", "gda_012b06a_e.shp" )
    
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
  


