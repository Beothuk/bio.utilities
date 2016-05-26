
parse.odf.file = function( fn ) {
  dta = readLines(fn )
  nheaderlines = grep( "-- DATA --", dta, fixed=T, useBytes=TRUE )
  header = dta[1: nheaderlines]
  mis = strsplit(header[grep('CRUISE_NUMBER=',header)],"CRUISE_NUMBER='")[[1]][2]
  mis = gsub("',","",mis)
  set = strsplit(header[grep('EVENT_NUMBER=',header)],"EVENT_NUMBER='")[[1]][2]
  set = as.numeric(gsub("',","",set))
  
  lat = strsplit(header[grep('INITIAL_LATITUDE=',header)],"INITIAL_LATITUDE=")[[1]][2]
  lat = as.numeric(gsub(",","",lat))
  lon = strsplit(header[grep('INITIAL_LONGITUDE=',header)],"INITIAL_LONGITUDE=")[[1]][2]
  lon = as.numeric(gsub(",","",lon))
  Y = read.table( fn, skip=nheaderlines, as.is=T)

  params = parse.odf.parameter.header( header) 

  if ( nrow( params ) != ncol(Y) ) {
    print( "Parse error .. variable length mismatch" )
    print( fn )
    print( head(Y) )
    print( params )
    stop()
  }
    
    params$pname[grep("CNTR", params$pname)] <- "scan"
    params$pname[grep("CRAT", params$pname)] <- "conductivity"
    params$pname[grep("OCUR", params$pname)] <- "oxygen_by_mole"
    params$pname[grep("OTMP", params$pname)] <- "oxygen_temperature"
    params$pname[grep("PSAL", params$pname)] <- "salinity"
    params$pname[grep("PSAR", params$pname)] <- "par"
    params$pname[grep("DOXY", params$pname)] <- "oxygen_by_volume"
    params$pname[grep("TEMP", params$pname)] <- "temperature"
    params$pname[grep("TE90", params$pname)] <- "temperature"
    params$pname[grep("PRES", params$pname)] <- "pressure"
    params$pname[grep("DEPH", params$pname)] <- "pressure"
    params$pname[grep("SIGP", params$pname)] <- "sigmaTheta"
    params$pname[grep("FLOR", params$pname)] <- "fluorometer"
    params$pname[grep("FFFF", params$pname)] <- "flag"
    params$pname[grep("LATD", params$pname)] <- "lat"
    params$pname[grep("LOND", params$pname)] <- "lon"
    params$pname[grep("ALT",  params$pname)] <- "altitude"
    
  vnames = paste( params$pname, params$units, params$nullvalue, sep="_" )
  names( Y) = vnames
  if(any(names(Y)=='lat')) Y <- Y[,-(grep("lat",names(Y)))]
  if(any(names(Y)=='lon')) Y <- Y[,-(grep("lon",names(Y)))]
  Y$depth <- pressure2Depth(Y[,grep('pressure',names(Y))],lat=lat)
  Y$mission <- mis
  Y$setno <- set
  Y$lat <- lat
  Y$lon <- lon
  return (Y)

}
 

