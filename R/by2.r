
  by2 = function (x, indices, func, var, newvars, ...) {
    # slower but more flexible
    x = convert2factor(x, indices)
    y = as.data.frame.table( by( data=x[,var], INDICES=x[,indices], FUN=func, ... ) )
    names(y) = c(indices, newvars)
    y = factor2character (y, indices)
    return (y)
  }


