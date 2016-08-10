#' @title print.command
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  print.command <- function(x) {
      default.args <- attr(x, "default.args")
      if (!length(default.args)) default.args <- list()
      res <- do.call(x, default.args, envir = parent.frame())
      if(!is.null(res)) print(res)
  }


