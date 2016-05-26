
	odds = function( M) {
		list( 
			odds=exp( M$coefficients ),
			ci = exp( confint(M) )
		)
	}

