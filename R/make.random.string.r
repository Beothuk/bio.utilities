#' @title make.random.string
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  make.random.string = function(x="_") {
    rand.seq = floor(runif(1)*10^9)
    out = paste( x, rand.seq, sep="_")
    return(out)
  }


