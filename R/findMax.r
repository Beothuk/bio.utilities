#' @title findMax 
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
findMax <- function(x,y){  
			np 	= length(x)
			ix 	= which.max(y)
			ixx = min(np-1,max(2,ix))
			tx 	= x[ixx + c(-1,0,1)]
			ty 	= y[ixx + c(-1,0,1)]
			co 	= coef(lm(ty ~ tx + I(tx^2)))
			xmax = co[2] /(-2 * co[3])
			ymax = co %*% (xmax^(0:2))
		return(c(xmax,ymax))
	}
