
  factor2character = function(x, vars=NULL) {
	if(is.null(vars)) {
			x = as.character(x)
		return(x)
		}
    for (i in vars) {
		x[,i] = as.character(x[,i])
		}
    return (x)
  }


