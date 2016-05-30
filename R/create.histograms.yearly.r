

  create.histograms.yearly = function( X, probs=c(0, 0.995) ) {
    xr=range(X)
    xl=quantile( X, probs=probs )
    br=c( xr[1], seq(xl[1], xl[2], length.out=100 ), xr[2] )
    ny = dim(X)[1]
    nn = matrix(0, ncol=ny, nrow=length(br)-1 )
    for (yy in 1:ny ) {
      nx = hist( X[yy,,], breaks=br, plot=FALSE )
      nn[,yy]=nx$counts
    }
    rownames(nn) = nx$mids
    return(nn) 
  }



