
  convert2factor = function(x, vars) {
    for (i in vars) x[,i] = as.factor(as.character(x[,i]))
    return(x)
  }

