#' @export
#' @title correlationMatrix
#' @description couldn't accurately describe
#' @param \code{X} 
#' @param \code{dfr} degrees of freedom
#' @param \code{meth.} 
#' @return \code{}
#' @note X is the matrix of values with each column representing a single variable.  The upper triangle of the resulting matrix is p-values and lower is cor test value
#' @family statistical
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
correlationMatrix <- function(X, dfr = nrow(X) - 2,meth.=c("pearson", "kendall", "spearman")) {
			 R <- round(cor(X,method=meth.),digits=4)
				 above <- row(R) < col(R)
				 r2 <- R[above]^2
				 Fstat <- r2 * dfr / (1 - r2)
				 R[above] <- 1 - pf(Fstat, 1, dfr)
				 if( any(R[above]==0)) {
				R[above][which(R[above]==0)]<-0.0001
	 		 }
			 R
			}
