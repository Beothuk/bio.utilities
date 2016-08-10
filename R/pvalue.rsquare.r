#' @title pvalue.rsquare
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
	pvalue.rsquare = function( M ) {
		# R^2 = SSDmodel/(SSDmodel+SSDres) 
		# F = DFres/DFmodel*SSDmodel/SSDres
	  # 1/R^2 = 1 + 1/F*DFmodel/DFres 
		# or, 
		# F = 1/(1/R^2 - 1)*DFres/DFmodel = R^2/(1-R^2)*DFres/DFmodel 
			# 
		# Actually, R^2 itself has a beta distribution and you could use pbeta
		# directly, but then you'd need to figure out (or recall) what the
		# relation between the DF and the shape parameters of the beta
		# distribution are. By my reckoning, this should do it:
		# pbeta(Rsq, 1/2, (N-2)/2, lower.tail=FALSE)
		# 
		# Residual standard error: 1.143 on 8 degrees of freedom
		# Multiple R-Squared: 0.0004207, Adjusted R-squared: -0.1245
		# F-statistic: 0.003367 on 1 and 8 DF, p-value: 0.9552
		# pbeta(0.0004207, 1/2, 8/2, lower=F)
		# >[1] 0.9551511
		
		dfres = df.residual(M)
		dfmod = sum( df.terms(M))
		rsq = summary(M)$r.squared
		Fval = 1/(1/ rsq - 1)*dfres/dfmod
		
		out = list( 
			rsquare=rsq, 
			dfmod = dfmod,
			dfres = dfres,
			Fval = Fval,
			pvalF = pf(Fval, sum( df.terms(M)) , df.residual(M), lower.tail=FALSE),
			pvalB = pbeta( rsq, dfmod/2, dfres/2,  lower.tail=FALSE )
		)
		return (out)

	}

