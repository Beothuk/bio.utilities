#' @export
#' @title coordinates.db
#' @description this is an assortment of coordinates for commonly used objects
#' @param \code{item} the desired object.  Valid values are 'gully','nens.ss.6-7','nens.ss.5-6','nens.ss.4-5','nens.ss.3-4','nens.ss.2-3','nens.ss.1-2','nens.ss.outside.1','nens.ss.outside.2','gulf-ss','nens-sens','cfa23.inshore-offshore','cfa23-cfa24','sens-cfa4x','shrimp.nw.sable','shrimp.louisburg','shrimp.bad.neighbours'
#' @return \code{} 
#' @examples
#' coordinates.db('gully')
#' @note It is tempting to mark this as deprecated, as it is not clear that these objects will be updated to reflect a more definitive source 
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  coordinates.db = function( item ) {
    
    if ( item=="gully" ) {
      a = as.data.frame( matrix( c( 
          -59.10051192315181,44.21678274656149,
          -59.33516115171256,44.10057784448195,
          -59.13782200164582,43.91718619192973,
          -59.13430015596633,43.58357892651157,
          -58.58296879641245,43.58284385250472,
          -58.58345034613519,43.78360045129342,
          -59.10051192315181,44.21678274656149
        ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
    
    if ( item=="nens.ss.6-7" ) {
      a = as.data.frame( matrix( c( 
        -59.8669459147477,46.61829003097517,
        -59.86714927555937,46.1903922915425
      ), ncol=2, byrow=T ) )
 
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }

    if ( item=="nens.ss.5-6" ) {
      a = as.data.frame( matrix( c( 
        -60.15013169910874,46.61686051036362,
        -60.15070296987705,46.25403077923779
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
  
    if ( item=="nens.ss.4-5" ) {
      a = as.data.frame( matrix( c( 
        -58.57169296505639,46.61743715738334,
        -60.35101630484722,46.61743036291101
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
  
    if ( item=="nens.ss.3-4" ) {
      a = as.data.frame( matrix( c( 
        -60.32934961857659,46.73377402095574,
        -58.70455622211595,46.73425821633046
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
  
    if ( item=="nens.ss.2-3" ) {
      a = as.data.frame( matrix( c( 
        -60.29739776341232,46.8490837267233,
        -58.83935581691834,46.8522334225455
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
   
    if ( item=="nens.ss.1-2" ) {
      a = as.data.frame( matrix( c( 
        -60.39965967598059,47.00047832780142,
        -59.01461782671211,47.00028076937365
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
   
    if ( item=="nens.ss.outside.1" ) {
      a = as.data.frame( matrix( c( 
        -59.99891390682926,47.83103013198976,
        -58.56775382241514,46.61649379280151
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
 
    if ( item=="nens.ss.outside.2" ) {
      a = as.data.frame( matrix( c( 
        -57.78591208190541,46.00109962205628,
        -58.56775382241514,46.61649379280151
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
  
    if ( item=="gulf-ss" ) {
      a = as.data.frame( matrix( c( 
        -60.41568418984078,47.03853523297152,
        -60.00014897319883,47.83408958793515 
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
    
    if ( item=="nens-sens" ) {
      a = as.data.frame( matrix( c( 
        -59.85247480316924,46.00291960992756,
        -57.78560987011954,46.00106076110973
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
      
    if ( item=="cfa23.inshore-offshore" ) {
      a = as.data.frame( matrix( c( 
        -59.92853837122961,44.69774735070251,
        -58.41005287016962,46.00038380222262
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
      
    if ( item=="cfa23-cfa24" ) {
      a = as.data.frame( matrix( c( 
        -60.66040620990439,45.58083805201212,
        -59.11881785180857,43.67610276909335
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
      
    if ( item=="sens-cfa4x" ) {
      a = as.data.frame( matrix( c( 
        -63.52502801857509,44.5005704612574,
        -63.33296001561555,44.33343763428088,
        -63.33161397633095,42.50186912534272
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
   
    if ( item=="shrimp.nw.sable" ) {
      a = as.data.frame( matrix( c( 
        -60.53348522264675,44.16713857065227,
        -59.83402446317178,44.16674842805921,
        -59.8337724318864,44.35020211840867,
        -60.53437630895549,44.35056350439965,
        -60.53348522264675,44.16713857065227
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
   
    if ( item=="shrimp.louisburg" ) {
      a = as.data.frame( matrix( c( 
        -59.16722567748156,45.50037490107675,
        -58.11756232854311,45.50029678441212,
        -58.11736586354162,45.91675134337378,
        -59.16724395727103,45.91694991968841,
        -59.16722567748156,45.50037490107675
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
   
    if ( item=="shrimp.eastern" ) {
      a = as.data.frame( matrix( c( 
        -60.99983106518073,44.58360971012488,
        -58.0005005513048,44.58361575122798,
        -58.00112052095971,44.9165492050831,
        -58.66697123168657,44.91801611900925,
        -58.66586013724016,45.00054787436935,
        -61.00063058037657,45.00080688407766,
        -60.99983106518073,44.58360971012488
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
   
    if ( item=="shrimp.bad.neighbours" ) {
      a = as.data.frame( matrix( c( 
        -60.95065555250798,45.31550857725852,
        -60.08311721156429,45.46714417665778,
        -60.08371925586215,45.80040191216285 
      ), ncol=2, byrow=T ) )
      a$elevation = 0
      names( a ) = c("lon", "lat", "elevation" )
      return( a )
    }
  
  }


