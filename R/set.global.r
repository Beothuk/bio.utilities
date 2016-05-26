
  set.global <- function (x, value) {
    x <- deparse(substitute(x))
    assign(x, value, pos=.GlobalEnv)
  }

