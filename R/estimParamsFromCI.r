

    estimParamsFromCI = function( CL, probs=c(0.025, 0.975), distribution="gamma", method="L-BFGS-B", plot=FALSE) {
      # CL  is estimated/approximate 95% confidence bounds 
      # probs = associated quantiles
      # pm0 = stating guess for parameters 
      # theoreticalCI is theoretical probabilty function 
      # pm are the parameters of the distributional function
      
      distrib =  paste('^',distribution, sep="" ) 

      if ( grepl( distrib, "normal", ignore.case=TRUE ) )  {
        CIoptim = function( pm, CL, probs) {
          theoreticalCI = pnorm( CL, mean=pm[1], sd = pm[2], log.p=TRUE )
          llik = ( theoreticalCI[1] - log( probs[1] ) )^2 + ( theoreticalCI[2] - log( probs[2] ) )^2
          return( llik ) 
        }
        pm0 = c( mean(CL), (CL[2]-CL[1])/3 )
        lower = c( -Inf, 1e-09 )
        resnames = c("mean", "sd")
        resdefault = c( 0, 1e5 )
        plotfn = function(x) dnorm(x, res[["mean"]], res[["sd"]])
        plot.range = CL + c( - pm0[2], + pm0[2] )
      }

 
      if ( grepl( distrib, "lognormal", ignore.case=TRUE ) )  {
        CIoptim = function( pm, CL, probs) {
          theoreticalCI =  plnorm( CL, meanlog=pm[1], sdlog=pm[2], log.p=TRUE  ) 
          llik = ( theoreticalCI[1] - log( probs[1] ) )^2 + ( theoreticalCI[2] - log( probs[2] ) )^2
          return( llik ) 
        }
        pm0 =  c( mean(log(CL)), log(CL[2])-log(CL[1])/3 )
        lower = c( -Inf, 1e-9 )
        resnames = c("meanlog", "sdlog")
        resdefault = c( 1e-3, 2 )
        plotfn =  function(x) dlnorm(x, res[["meanlog"]], res[["sdlog"]])
        plot.range = CL * c( 0.01, 1.5 ) 
      }

  
      if ( grepl( distrib, "gamma", ignore.case=TRUE ) )  {
        CIoptim = function( pm, CL, probs) {
          theoreticalCI = pgamma( CL, shape=pm[1], rate=pm[2], log.p=TRUE  )
          llik = ( theoreticalCI[1] - log( probs[1] ) )^2 + ( theoreticalCI[2] - log( probs[2] ) )^2
          return( llik ) 
        }
        pm0 = c( 0.5, 1/mean( CL ))
        lower = c( 1e-9, 1e-9 )
        resnames = c("shape", "rate")
        resdefault = c( 0.1, 0.01 )
        plotfn = function(x) dgamma(x, res[["shape"]], res[["rate"]])
        plot.range = CL * c( 0.01, 1.5 ) 
      }

      res = optim( pm0, CIoptim, CL=CL, probs=probs, lower=lower, method=method)
      if (res$convergence==0) {
        res = res$par
      } else {
        res= resdefault 
      }

      names(res) = resnames
     
      if (plot) {
        curve( plotfn, plot.range[1], plot.range[2] )
        abline( v=CL[1], lty="dotted" )
        abline( v=CL[2], lty="dotted" )
      }

      return(res)

      # ----------
      debug = FALSE
      if (debug) {
        CL = c(0.5, 10) # initial guess of 95% CI 
        estimParamsFromCI( CL, pm0=c(0.1, 0.1) , distribution="gamma", plot=T)
        #  E(X) = shape * scale = shape / rate = res[["shape"]] / res[["rate"]] = 3.69
        #  Var(X) = shape*scale^2 = shape / (rate^2) = res[["shape"]] / res[["rate"]] ^2 =  6.32
        qgamma( 0.025, res[["shape"]], res[["rate"]] )  # = 0.5
        qgamma( 0.975, res[["shape"]], res[["rate"]] )  # = 9.99
        curve( dgamma(x, res[["shape"]], res[["rate"]]), 0.0005, 100)
      
      }
    }
   
  

