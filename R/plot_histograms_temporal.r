#' @title plot_histograms_temporal
#' @description this adds histograms to the current figure
#' @param \code{mm} is a matrix of the actual distributions  
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  plot_histograms_temporal = function( mm, xlab="", ylab="", barscale=0.75, barcol="darkgray", overlaydata=NULL ) {
    xx = as.numeric(colnames(mm) )
    yy = as.numeric(rownames(mm) )

    xlim = range(xx)
    ylim = range(yy)
    barwidth = (ylim[2] - ylim[1]) / nrow(mm)
     
    par(new = FALSE) 
    par(mar = c(5, 4, 0, 2)) 
    plot(0, 0, type="n", xlim=xlim, ylim=ylim, bty="n", xaxs = "i", xlab=xlab, ylab=ylab )
  
    if ( !is.null(overlaydata) ) {
      lines( loess( overlaydata ~ xx, span=1), lwd=3, col="slategray" )
    }

    for (i in 1:length( xx )){ 
      xrange <- xlim - xx[i]
      ser <- mm[,i] / max(mm) * barscale 
      ser [which( ser < 0.01)] = NA
      names(ser)=NULL
      par(new = TRUE) 
      barplot(ser, width=barwidth, horiz=TRUE, axes=FALSE, xlim=xrange,
              col=barcol, space=0, xpd=T, xlab="", ylab="" ) 
    }

  } 


