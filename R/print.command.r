  print.command <- function(x) {
      default.args <- attr(x, "default.args")
      if (!length(default.args)) default.args <- list()
      res <- do.call(x, default.args, envir = parent.frame())
      if(!is.null(res)) print(res)
  }


