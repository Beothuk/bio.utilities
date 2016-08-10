#' @title jae.hist
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  jae.hist = function(x, s0, s1, bwh, bwd, title, ...) {
    breaks = seq(s0, s1, bwh)
    out = hist(x, breaks=breaks, main=title, ...)
    k = density(x, bw=bwd)
    k$y = k$y * (k$n) * bwh
    lines(k, lwd=2)
    return(out)
  }



