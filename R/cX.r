#' @export
#' @title cX
#' @description write table to paste into excel
#' @param \code{X} 
#' @param \code{row.names} should row names be copied too ? (Defaults to \code{F})
#' @return \code{} 
#' @author unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @examples
#' cX(A)
#' @export
cX <- function(X,row.names=F) {
	write.table(X,'clipboard-512',sep="\t",row.names=row.names)
}