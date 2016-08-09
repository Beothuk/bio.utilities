#' @title odds
#' @description unknown
#' @family abysmally documented
#' @author unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
	odds = function( M) {
		list( 
			odds=exp( M$coefficients ),
			ci = exp( confint(M) )
		)
	}

