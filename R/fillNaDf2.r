#' @title fillNaDf2
#' @description function to fill in nas with vaules from a table matching one or several columns
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
		fillNaDf2 <- function(naDf, fillDf, mergeCols, fillCols) {
		 	 fillB <- do.call(paste, c(fillDf[, mergeCols, drop = FALSE], sep="\r"))
		  	naB <- do.call(paste, c(naDf[, mergeCols, drop = FALSE], sep="\r"))
		  	m <- match(naB, fillB)
		  	for(col in fillCols) {
		    fix <- which(is.na(naDf[,col]))
		    naDf[fix, col] <- fillDf[m[fix],col]
			  }
		  	naDf
				}
