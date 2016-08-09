#' @title rX
#' @description read table to copied from excel
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
rX <- function(header=T) {
	read.table('clipboard-512',sep="\t",header=header)
}