#' @title topo.colors2
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
topo.colors2 = function (n) 
{
    if ((n <- as.integer(n[1])) > 0) {
        j <- n%/%3
        k <- n%/%3
        i <- n - j - k
        c(  if (i > 0) hsv(h = seq(from = 45/60, to = 31/60, length = i)), 
            if (j > 0) hsv(h = seq(from = 30/60, to = 16/60, length = j)), 
            if (k > 0) hsv(h = seq(from = 15/60, to = 1/60, length = k), 
              s = 0.5, v = 1))
    }
    else character(0)
}

