#' @title Rsquared_lm
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  Rsquared_lm = function(o) {
    R2 <- summary(o)$r.squared
    names(R2) <- 'Rsquared'
    R2
  }
 
