#' @title arcinfo.read.example 
#' @description This function used to read in shapefiles for use in R
#' @seealso 
#' @note DEPRECATED!  maptools::read.shape() no longer exists
  arcinfo.read.example = function() {
    .Deprecated()
    library(maptools)
    gpclibPermit()
  
    # data.dir = "C:\\NATHbio\\Data\\Shapefiles\\DA\\2006"
    data.dir = "/home/jae/nath/ccpp/R"

    cdda.shapes = file.path( data.dir, "ns.shapes.rdata")
    if ( import.shapes ) {
      fn = file.path( data.dir, "gda_012b06a_e.shp" )
      ns = read.shape( fn, dbf.data=TRUE, verbose=TRUE, repair=FALSE)
      save(ns, file=cdda.shapes , compress=T)
    }
   
    load( cdda.shapes )
    length(ns$Shapes)
    unlist(lapply(ns$att.data, class))
    cdda = as.character( ns$att.data$DAUID )
    get.Pcent(ns)
    
    a = Map2poly(ns)
    o <- match(a$att.data$DAUID, "12010030" )
    plot(a)

    r = sapply( a, polygon.area.lon.lat,  proj.type="utm20", simplify=T )
    r = cbind( ns$att.data, r )
    save( r, file=file.path( data.dir, "sa.rdata" ), compress=T )
    require (foreign)
    write.dbf( r,  file.path( data.dir, "sa.dbf" )) 

  }

	 

