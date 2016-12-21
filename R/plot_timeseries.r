#' @title plot_timeseries
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  plot_timeseries = function ( x, vars, regions, outdir="timesseries", backtransform=T) {

    xrange = range(x$year)
    xrange[1] = xrange[1] - 0.5
    xrange[2] = xrange[2] + 0.5

    for (reg in regions) {
    for (v in vars) {
      u = x[ which(x$variable==v & x$region==reg),]
      u = u[is.finite(u$mean) ,]
      if ( nrow(u) < 1) next()
      u = u[order(u$year),]
      outfile = paste( v, reg, sep="." )
      if (!backtransform) {
        xval = u$year
        yval = u$mean
        ub = u$mean+u$se
        lb = u$mean-u$se
        good = which( is.finite(xval + yval + ub + lb) )
      }
      if (backtransform) {
        xval = u$year
        yval = 10^u$mean - 1
        ub = 10^(u$mean+ u$se) - 1
        lb = 10^(u$mean- u$se) - 1
        good = which( is.finite(xval + yval + ub + lb) )
      }
      if (length(good) < 2) next()

      xval = xval[good]
      yval = yval[good]
      ub = ub[good]
      lb = lb[good]

      errbar(xval, yval, ub, lb, type="n", axes=F,
            xlab="Years", ylab=toupper(gsub("[.]", " ", v)), xlim=xrange )  # from Hmisc
      lines( xval, yval, col="orange", lty="solid", lwd=5 )
      points(x=xval, y=yval, pch=10)
      axis( 1 )
      axis( 2 )

      Pr(dev="png", dname=outdir, fname=outfile, width=6, height=3)
      print (outfile)
    }}

    return(NULL)
  }


