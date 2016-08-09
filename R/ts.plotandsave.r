#' @title ts.plotandsave
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  ts.plotandsave = function ( x, y, lb=NULL, ub=NULL, w=NULL, outdir=NULL, action=NULL, title="default", filename="NULL", smooth=NULL) {

      require(Hmisc)

      xrange = range(c(x+0.5, x-0.5))

      if (!is.null(lb)) {
        i = which(is.finite(x*y*lb*ub))
        errbar(x[i], y[i], ub[i], lb[i], type="n", axes=F, xlab="Years",
                            xlim=xrange, ylab=title, cex=2 )
      }
      if (is.null(lb)) {
        i = which(is.finite(x*y))
        plot(x[i], y[i], type="n", axes=F, xlab="Years",
                            xlim=xrange, ylab=title, cex=2 )
      }

      if (is.null(w)) w = rep(1, length(x[i]))
      if (is.null(smooth)) smooth=0.1
      lines( lowess( x[i], y[i], f=smooth),  col="orange", lty="solid", lwd=4 )
      points(x, y, pch=10)

      axis( 1 )
      axis( 2 )

      if (is.null(filename)) filename = title

      if (action=="save") {
        Pr(dev="png", dname=outdir, fname=filename, width=8, height=4)
      }
  }



