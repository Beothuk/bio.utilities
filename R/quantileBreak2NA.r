#' @title quantileBreak2NA
#' @description changing outliers and infinite values to NA , if qu has two elements will be treated as lower and upper, otherwise it will be an upper quantile only
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
quantileBreak2NA <- function(x, qu=0.99) {
				i = which(is.infinite(x))
				x[i] <- NA
				qi = quantile(x,na.rm=T,probs=qu)
				if(length(qi)>1)  j = which(x<qi[1] | x>qi[2])
				if(length(qi)==1) j = which(x>qi)
				x[j] <- NA
				return(x)
	}