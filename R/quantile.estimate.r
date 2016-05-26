
	quantile.estimate = function(x) {
		# essentially the same as ecdf, but over-writes the max value with the next largest quantile
		i = which( is.finite( x) )
		pr = ecdf(x[i])( x[i] )
		ix = which( pr ==1 )
		if ( !( length(ix) %in% c(0, length(x)) ))  pr[ix] = max( pr[-ix] )
		x[i] = pr
		return(x)
	}

