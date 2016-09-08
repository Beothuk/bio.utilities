#' @title errorbars
#' @description create plots of mean y after binning x values, adding 1 SE bars
#' @param \code{b} NULL
#' @param \code{v} NULL
#' @param \code{br} br is the number of bins to be created from the x-values
#' @param \code{nfilter} defaults to 0
#' @param \code{lowess} defaults to 0.4
#' @param \code{trim} defaults to 0
#' @param \code{xlab} NULL
#' @param \code{ylab} NULL
#' @param \code{db} NULL
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export

  errorbars = function(b, v, br="Sturges", nfilter=0, lowess=0.4, trim=0, xlab, ylab, db, ...)  {
    # ... params to send to errbar (labels, lty, etc)
    b[,v[2]] = variable.recode( b[,v[2]], v[2], direction="forward", db=db )

    good = which(is.finite(rowSums(b[,v], na.rm=T)))
    x = b[good, v[1]]
    y = b[good, v[2]]
    h = hist(x, breaks=br, plot=F)
    mids = h$mids
    delta = h$breaks[2] - h$breaks[1]
    d = cut(x, breaks=h$breaks)
    e =  tapply(X=y, INDEX=d, FUN=mean, simplify=T, na.rm=T, trim=trim)
    e =  data.frame(mean=e)
    f =  tapply(X=y, INDEX=d, FUN=var, simplify=T, na.rm=T)
    f =  data.frame(var=f)
    g =  tapply(X=y, INDEX=d, FUN=length, simplify=T)
    g =  data.frame(n=g)
    out = cbind(e,f,g)
    out$se = sqrt(out$var/(out$n-1))
    out$mids = h$mids
    out = out[ out$n > nfilter ,]
    r = which (is.finite(out$mids+out$mean) )

    yplus = variable.recode( x=(out$mean+out$se), v[2],  direction="backward", db=db)
    yminus = variable.recode( x=(out$mean-out$se), v[2],  direction="backward", db=db )
    out$mean = variable.recode( x=(out$mean), v[2],  direction="backward", db=db )

    errbar( x=out$mids, y=out$mean, yplus=yplus, yminus=yminus,
            xlab=xlab, ylab=ylab, xlim=c(min(out$mids, na.rm=T)-delta, max(out$mids, na.rm=T)+delta),  axes=F )  # from Hmisc

   lines(lowess(out$mids[r], out$mean[r], f=lowess), lty="solid", col="orange", lwd=4 )
#    lines(
#        loess(out$mean[r] ~ out$mids[r], weights=out$n[r], na.action="na.omit", span=lowess),
#        lty="solid", col="orange", lwd=4
#        )
      axis( 1 )
      axis( 2 )
      abline(h=0, lty=3)

    text(  x=out$mids, y=out$mean, labels=out$n, pos=4 )
    points(  x=out$mids, y=out$mean )

    return (out)
  }


