#' @title hist_bivariate
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
hist_bivariate = function(x,y, method="fd", xrange=NULL, yrange=NULL) {
  
  xhist <- hist(x, plot=F, method )
  yhist <- hist(y, plot=F, method )

  layout(mat=matrix(c(2,0,1,3),2,2,byrow=TRUE), widths=c(3,1), heights=c(1,3), respect=TRUE)

  if (is.null(xrange)) xrange <- range(x, na.rm=T)
  if (is.null(yrange)) yrange <- range(y, na.rm=T)

  plot(x, y, xlim=xrange, ylim=yrange, xlab="", ylab="", axes=F)
  axis(1)
  axis(2)

  par(mar=c(0,3.5,3.5,1))
  barplot(xhist$counts, axes=F, space=0)

  par(mar=c(5,0,5,1))
  barplot(yhist$counts, axes=F, space=0, horiz=TRUE)
  return(NULL)
}


