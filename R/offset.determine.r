 
  offset.determine = function(x) {
    offset = 0
    y = x[ is.finite(x) & x>0 ]
    if( length(y) > 0) offset = min(y)
    return(offset)
  }


