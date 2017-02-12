#' @title make.list
#' @description Make a simple expanded list of parameter values with which parallel runs can be made.
#' @family abysmally documented
#' @author  Jae Choi, \email{jae.choi@dfo-mpo.gc.ca}
#' @export
# define compact list of variable (e.g.,  year, var, etc)  combinations for parallel processing
# which can be accessed within a parallel run to recover variable comnbinations using a single index 
#    outside of parallel run
#    p = make.list( list(p$vars.to.model, p$years.to.model, p$regions.to.model), Y=list() )
#    ...
#    inside of a parallel run
#    i = 1 ... parallel nids or "nruns"
#     v = p$runs[i,1]
#     y = p$runs[i,2]
#     r = p$runs[i,3]
     

  make.list = function( Z, Y=list(), delimit="~" ) { 
    
    nvars = length(Z)  # Z must be a list
    sm = NULL
    for (i in 1:nvars) {
      sm = c( sm, mode( Z[[i]] ) )
    }
    
    Q = expand.grid(Z)
    X = Q[,1]
    if ( nvars > 1 ) {
      for (i in 2:nvars) {  X = paste( X, Q[,i], sep=delimit )   }
    } 
    
    Y$process.list = list( data=X, sm=sm, delimit=delimit, nvars=nvars, varnames=names(Q), Z=Z )
    Y$runs = break.list( Y$process.list )
    Y$nruns = nrow( Y$runs )
    
    return( Y)
    
  }


