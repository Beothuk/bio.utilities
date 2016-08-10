#' @title matrix.multiply
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export

  matrix.multiply = function (x, y, nfac=2){ 
    ndat = dim(x)[1]
    z = matrix(0, nrow=ndat, ncol = nfac)
    for (j in 1:nfac) { 
      for (i in 1:ndat) { 
        z[i,j] = sum ( x[i,] * t(y[,j]), na.rm=T )
      } 
    }
    return (z)
  }  


