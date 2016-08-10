#' @title factor2number
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  factor2number = function(x, vars=NULL) {
	if(is.null(vars)) {
	x = as.numeric(levels( x ))[as.integer( x )]
	return(x)
	}
    for (i in vars) {
			if ( is.factor( x[,i]	) ) {
				x[,i] = as.numeric(levels( x[,i] ))[as.integer( x[,i] )]
			} else if ( is.character( x[,i] ) ) {
				x[,i] = as.numeric(as.character(x[,i]))
			}
		}
		return(x)
  }


