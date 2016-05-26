
  duplicates.toremove = function(x) {
    e = NULL
    d = which(duplicated(x))
    e = which(x %in% x[d])
    return(e)
  }

