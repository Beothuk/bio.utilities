#' @title lsos
#' @description shorthand for .ls.objects
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
# 
lsos <- function(..., n=10) {
    ls.objects(..., order.by="Size", decreasing=TRUE, head=TRUE, n=n)
}