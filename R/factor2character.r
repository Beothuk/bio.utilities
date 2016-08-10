#' @title factor2character
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  factor2character = function(x, vars=NULL) {
	if(is.null(vars)) {
			x = as.character(x)
		return(x)
		}
    for (i in vars) {
		x[,i] = as.character(x[,i])
		}
    return (x)
  }


