
  which.quantile = function( x, probs, inside=TRUE ) {
    qnts = quantile( x, probs=probs, na.rm=TRUE ) 
    
    if ( inside ) {
      return( which(x < qnts[2]  & x > qnts[1] ) )
    } else {
      return( which(x > qnts[2]  | x < qnts[1] ) )
    }
  }

