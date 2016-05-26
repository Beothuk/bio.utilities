
	
	summary.deviance = function( M ) {
	  deviance = M$null.deviance-M$deviance
		df = M$df.null-M$df.residual
		p = dchisq( deviance, df )
		list(
			deviance = deviance, 
			df = df,
			p = p,
			logLik = logLik( M )
		)
	}

