#' @export
#' @title break.list
#' @description couldn't accurately describe
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  break.list = function( X, delimit=NULL, return.columns=NULL, nvars=NULL ) {
    
    if (is.null(delimit)) delimit = X$delimit
    if (is.null(nvars) ) nvars=X$nvars 
    if (is.null(return.columns)) return.columns=c(1:nvars)
    
    if (nvars > 1) {
      Y = as.data.frame( matrix( unlist( strsplit( X$data, delimit )), ncol=nvars, byrow=T ))
      for ( i in 1:nvars )  {
        Y[,i] =  as.character( Y[,i] )
        storage.mode( Y[,i] ) =  X$sm[i] 
      }
      names(Y) = X$varnames
      out = Y[, return.columns] 

    } else {

      Y = data.frame( X$data )
      names(Y) = X$varnames
      Y[,X$varnames] = as.character( Y[,X$varnames] )
      storage.mode( Y[,X$varnames] ) =  X$sm
      out = Y 
    
    }

    return (out)

  }


