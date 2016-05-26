
  copy.data.structure =function( x) {
    # there must be an easier way of doing this ?
    if (class(x) == "data.frame") {
      y = x[ 1, ]
      y = y[-1, ]
      return (y)
    }
  }

