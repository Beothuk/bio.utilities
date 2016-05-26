
  filter.season = function( x, period, index=T ) {
    # read julian day and categorise
    if      (period=="summer") { 
      i = which( (x>150) & (x<250) )
    } else if (period=="spring") {
      i = which(  x<149 )
    } else if (period=="winter") {
      i = which(  x>251 )
    } else  {
      i = c(1:length(x))
    }
    
    if (!index) i = x[i] 
    return (i)

  }


