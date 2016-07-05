#' @export
#' @title cor.prob
#' @description couldn't accurately describe
#' @param \code{X} 
#' @param \code{dfr} degrees of freedom
#' @return \code{} 
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
cor.prob <- function(X, dfr = nrow(X) - 2) {
	 R <- cor(X)
	 above <- row(R) < col(R)
	 r2 <- R[above]^2
	 Fstat <- r2 * dfr / (1 - r2)
	 R[above] <- 1 - pf(Fstat, 1, dfr)
	 R
}
