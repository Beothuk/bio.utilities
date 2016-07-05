#' @export
#' @title applySum
#' @description apply a sum and return a formated data frame. If 3 columns of data then a weighted sum is returned, if 1 column (vector) then a count is returned. Must contain index, variable, weight in this sequence
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  applySum = function( f, method="fast", newnames=NULL ) { 
    cnames= c("id", "x", "w" ) 
    
    if (is.null( newnames )) newnames=names(f)
    
    if( is.vector(f) ) { 
   
      out = as.data.frame( xtabs( ~ f) , stringsAsFactors=FALSE  )
    
    } else { 
      
      # data.frame metod

      nv = ncol(f)
      names(f) = cnames[1:nv]
      
      if( nv==3 ) f$x = f$x* f$w

      o = which( is.finite( f$x) )
      if ( length(o) == 0 ) return( "No data?")
      f = f[o,]

      if (method=="slow") { 
        r = by( f, f$id, with, sum( x, na.rm=TRUE ))
        out = data.frame( id=names(r), x=as.numeric(as.vector(r)) , stringsAsFactors=FALSE ) 
      
      } else if (method=="fast") {
        f$id = as.factor( f$id )
        l0 = 1 / median( f$x, na.rm=TRUE ) # a scaling factor to help avoid overflow errors
        f$x = as.numeric( f$x * l0)
        out = as.data.frame( xtabs( f$x ~ f$id) / l0, stringsAsFactors=FALSE )
      } 

    }

    names(out) = newnames[1:2]
    return( out )
  }



