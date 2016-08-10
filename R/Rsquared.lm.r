#' @title Rsquared.lm
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  Rsquared.lm = function(o) {
    R2 <- summary(o)$r.squared
    names(R2) <- 'Rsquared'
    R2
  }
 
