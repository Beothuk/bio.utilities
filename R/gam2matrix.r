#' @title gam2matrix
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
 gam2matrix = function( oo, i=1, n2=100 )  {

    xterm <- oo$smooth[[i]]$term[1]
    yterm <- oo$smooth[[i]]$term[2]

    raw <- data.frame(x=as.numeric(oo$model[xterm][[1]]), y = as.numeric(oo$model[yterm][[1]]))

    xm <- seq(min(raw$x), max(raw$x), length = n2)
    ym <- seq(min(raw$y), max(raw$y), length = n2)
    by <- rep(1, n2^2)

    xx <- rep(xm, n2)
    yy <- rep(ym, rep(n2, n2))

    dat <- data.frame(x=xx, y=yy, by=by)
    names(dat) <- c(xterm, yterm, oo$smooth[[i]]$by)

    op <- PredictMat(oo$smooth[[i]], dat)
    first <- oo$smooth[[i]]$first.para
    last <- oo$smooth[[i]]$last.para
    p <- oo$coefficients[first:last]
    offset <- attr(oo, "offset")
    if (is.null(offset)) {
      fit <- op %*% p
    } else {
      fit <- op %*% p + offset
    }
    
    mat = matrix( fit, n2, n2 )
    out = list( x=xm, y=ym, fit=mat )
    return( out) 
  }


