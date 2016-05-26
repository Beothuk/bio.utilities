
parse.odf.parameter.header = function ( header ) {
    
  iparams = grep( "PARAMETER_HEADER,", header, fixed=T, useBytes=TRUE )
  ip = c( iparams, length(header) ) 
  
  vn = data.frame( i=1:length( iparams) )
  vn$pname = ""
  vn$units =""
  vn$nullvalue = NA
  
  for ( i in 1:length(iparams) ) {
    ph = header[ ip[i]:ip[i+1] ]
    
    gg = "NAME='"
    nm = grep( gg, ph, fixed=TRUE )
    pname = gsub( gg, "", ph[nm] )
    pname = gsub("',$", "", pname )
    pname = gsub( "[[:space:]]", "", pname )

    gg = "UNITS='"
    nm = grep( gg, ph, fixed=TRUE )
    unit = gsub( gg, "", ph[nm] )
    unit = gsub("',$", "", unit )
    unit = gsub( "[[:space:]]", "", unit )
    gg = "NULL_VALUE='"
    nm = grep( gg, ph, fixed=TRUE ) 
    if(is.integer(nm)) gg = "NULL_VALUE=";    nm = grep( gg, ph, fixed=TRUE ) #AMC added
    nv = gsub( gg, "", ph[nm] )
    nv = gsub("',$", "", nv )
    nv = gsub( "[[:space:]]", "", nv )
    nv = gsub( ",", "", nv )
    nv = as.numeric( nv )
    
    vn$pname[i] = pname
    vn$units[i] = unit
    vn$nullvalue[i] = nv
  
  }
  
  return (vn )

}


