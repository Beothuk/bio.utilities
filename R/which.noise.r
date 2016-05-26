which.noise = function( xy, method="",  probs=c(0.025, 0.975), lags=c(1,2,3,2,1)  ) {
  
  # similar to interpolate.xy.robust  
  # given a vector, or xy, identify errors or noise

  debug = FALSE
  # debug = TRUE
  if( debug ){
    method="sequential"
    probs=c(0.025, 0.975)
    lags=c(1,2,3,2,1) 
    xy= 1:100
    nb = 10
    xy[sample( 1:length(xy), nb)] = runif( nb ) * 1000 
  }

  if (ncol(xy) ==1 ) {
    nz = length(xy)
    z = data.frame( x=1:nz, y=xy ) 
  } else  if (ncol(xy) ==2 ) {
    nz = nrow(xy)
    z = data.frame( xy)
    names(z) = c("x", "y" )
  } else {
    stop( "Error: y or c(x,y) expected")
  }
    
  z$y0 = z$y  # a copy in case we need original data
  z$noise=FALSE  

  if (method =="sequential") { 
    # check adjacent values and reject if differences are greater than a given range of quantiles (95%)
    for ( lg in lags ) { 
      finished = FALSE
      noise.n0 = 2  
      noise.n = noise.n0-1  # staring with a dummy value
      while ( noise.n > 0 ) {
        zd = diff( z$y, lag=lg )
        z$ydiff = c( zd , rep(NA,lg ))  # padding with NA's 
        yquants = quantile( z$ydiff, probs=probs, na.rm=T) 
        i = which( z$ydiff < yquants[1] | z$ydiff > yquants[2]) 
        suspect.noise =  c(i, i+lg )
        noise = suspect.noise[ duplicated(suspect.noise, incomparables=c(1, nz, NA)) ] # exclude terminal points
        noise.n0 = noise.n
        noise.n = length( noise )
        if (noise.n0 == noise.n) break()  # converged upon a solution
        if (noise.n >0 ) {
          z$noise[noise] = TRUE
          allnoisydata = which(z$noise)
          z$y[allnoisydata ] = NA  
          z$y[allnoisydata ] = approx( x=z$x, y=z$y, xout=allnoisydata, method="linear", rule=2 )$y
        } 
      }
    }
  }


 if (method=="loess") {
    for( sp in seq( 0.34, 0.02, by=-0.02 ) ) {
      # ID a good span where loess solution ~ real data
      lmod = try( loess( y ~ x, data=z, span=sp, control=loess.control(surface="direct") ), silent=TRUE )
      if ( "try-error" %in% class(lmod) ) next()
      z$y.smoothed = NA
      z$y.smoothed = predict( lmod ) 
      lmtest = try( lm( y.smoothed ~ y, z ), silent=TRUE) 
      if ( "try-error" %in% class(lmtest) ) next()
      lsumm = summary( lmtest )
      if (lsumm$r.squared > 0.95 ) {
        # only accept solutions if it produces predictions that are pretty close to original data 
        z$y.diff = z$y - z$y.smoothed
        yquants = quantile( z$y.diff, probs=probs, na.rm=TRUE )
        i =  which( z$y.diff < yquants[1] | z$y.diff > yquants[2] )
        if (length(i) > 0) z$noise[i] = TRUE
        break()
      }
    }
  }

  return( which( z$noise) )

  if (debug) {
    plot ( y0 ~ index, z, pch=20, cex=0.3, col="orange" )
    points ( y ~ index, z, pch=20, cex=0.2, col="green" )
    points ( y0 ~ index, z[!z$noise,], pch=20, cex=0.2, col="blue" )
  }


}


