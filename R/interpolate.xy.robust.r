#' @title interpolate.xy.robust
#' @description Interpolate some xy data used by netmensuration and mode fifnding methods.
#' @family abysmally documented
#' @author  Jae Choi, \email{jae.choi@dfo-mpo.gc.ca}
#' @export
interpolate.xy.robust = function( xy, method, target.r2=0.9, mv.win=10, trim=0.05,
  probs=c(0.025, 0.975), loess.spans=seq( 0.25, 0.01, by=-0.01 ), inla.model="rw2",
  smoothing.kernel=kernel( "modified.daniell", c(2,1)), nmax=3, inla.h=0.1, inla.diagonal=0.01, inla.ngroups=400 ) {

  # simple interpolation methods
  # target.r2 == target prediction R^2

  if (FALSE) {
    x=seq(-5,5,by=0.1)
    y=sin(x) + runif(length(x))^2
    xy = data.frame( x=x, y=y )
    target.r2=0.9
    nmax=5  # max number of times to try to reduce data set
    probs=c(0.025, 0.975)
    loess.spans=seq( 0.2, 0.01, by=-0.01 )
    inla.model="rw2"
    smoothing.kernel=kernel( "modified.daniell", c(2,1))
  }

  if ( is.vector(xy) ) {
    nz = length(xy)
    z = data.frame( x=1:nz, y=xy )
  } else {
    if (ncol(xy) == 2 ) {
      nz = nrow(xy)
      z = data.frame( xy)
      names(z) = c("x", "y" )
    } else {
      stop( "Error: y or c(x,y) expected")
    }
  }


  z$p= NA
  z$noise = FALSE
  z$loc = 1:nz  # row index used in seq lin method


  if (method == "moving.window" ) {
    z$p = z$y
    for (nw in mv.win:1) {
      win = -nw:nw
      z$p = NA
      for( i in 1:nz ) {
        iw = i+win
        iw = iw[ which( iw >= 1 & iw <=nz ) ]
        z$p[i] = mean( z$y[iw], na.rm=TRUE )
      }
      z$diff = abs( z$p - z$y )
      qnts = quantile( z$diff, probs=(1-trim), na.rm=TRUE )  # remove upper quantile
      ii = which( z$diff > qnts )
      if (length(ii) > 0) z$p[ ii ] = NA
      z$p[ii] = approx( x=z$x, y=z$p, xout=z$x[ii], method="linear", rule=2 )$y
      rsq = cor( z$p, z$y, use="pairwise.complete.obs" )^2
      if (!is.na(rsq)) {
        if (rsq > target.r2 ) break()
      }
    }
  }


  if (method =="sequential.linear") {
    # check adjacent values and reject if differences are greater than a given range of quantiles (95%)

      m = z # locs are the location indices for z$y ... to bring back into "z"
      m = m[ which(is.finite( m$y)) , ]
      lg = 1 # lag
      nw = nrow( m )  # staring number of data points
      nw_target =  nw * (1-trim)  # proportion of data to retain (not trim)

      while ( nw > nw_target ) {
        yd0 = c( diff( m$y, lag=lg ) , rep( 0, lg )) # diffs left-right # padding with 0's  (no change)
        dm = quantile( yd0, probs=probs, na.rm=TRUE )
        n = which( yd0 < dm[1] | yd0 > dm[2] )
        if (length(n) == 0 ) break()
        if ( length(n) > 0 ) m = m[-n, ]  # remove na's and then assess again
        nw = nrow( m )
      }

      # m$locs contains indices of "good" data .. setdiff to get the "bad" .. set to NA and then
      #   infill missing with interpolated values
      ii = setdiff( 1:nz, unique(m$loc) )
      if (length(ii) > 0)  {
        z$y[ii] = NA
        afun = approxfun( x=z$x, y=z$y,  method="linear", rule=2  )
        z$y[ii] = afun( z$x[ii] )
      }
    z$p = z$y
  }


  if (method =="local.variance") {
    # local variance estimates used to flag strange areas .. where local variance is too high .. remove the data

    z$p = z$y
    for (nw in mv.win:1) {
      z$Zvar = NA
      win = c( -nw : nw )
      for (i in 1:nz ) {
        iw = i+win
        iw = iw[ which(iw >=1 & iw<= nz)]
        if (length(iw)> 3)  z$Zvar[i] = var( z$p[iw], na.rm=TRUE )
      }
      qnts = quantile( z$Zvar, probs=(1-trim), na.rm=TRUE )  # remove upper quantile
      ii = which( z$Zvar > qnts )
      if (length(ii) > 0) z$p[ ii ] = NA
      afun = approxfun( x=z$x, y=z$p,  method="linear", rule=2  )
      z$p[ii] = afun( z$x[ii] )
      rsq = cor( z$p, z$y, use="pairwise.complete.obs" )^2
      if (!is.na(rsq)){
        if (rsq > target.r2 ) break()
      }
    }
  }


  if (method == "loess" ) {
    var0 = var( z$y, na.rm=TRUE)
    for( sp in loess.spans ) {
      # ID a good span where loess solution ~ real data

      loess.mod = try( loess( y ~ x, data=z, span=sp, control=loess.control(surface="direct"),na.action = na.exclude ), silent=TRUE )
      if ( "try-error" %in% class(loess.mod) ) next()
      z$p = predict( loess.mod, newdata=z )
      rsq = cor( z$p, z$y, use="pairwise.complete.obs" )^2
      if (!is.na(rsq)) {
        if (rsq > target.r2 ) {
         # if ( var( z$p, na.rm=TRUE) < var0 ) 
		break()
        }
      }
    }
  }



  if (method == "inla") {

    require(INLA)
    ymean = mean( z$y, na.rm=TRUE )
    z$y = z$y - ymean
    nn = abs( diff( z$x) )
    dd = median( nn[nn>0], na.rm=TRUE )
    z$xiid = z$x = jitter( z$x, amount=dd / 20 ) # add noise as inla seems unhappy with duplicates in x?

    rsq = 0
    nw = length( which(is.finite( z$y)))
    nw0 = nw + 1
    count = 0

    ndat = nrow( z )
    #if ( ndat < inla.ngroups ) inla.ngroups = ndat

    # m = get("inla.models", INLA:::inla.get.inlaEnv())
    # m$latent$rw2$min.diff = NULL
    # assign("inla.models", m, INLA:::inla.get.inlaEnv())

    # inla's default RW2 resolution is too coarse, causing incomplete solution:
    # alter a bit as this is potentially a smoothed series
    #menv = get("inla.models", INLA:::inla.get.inlaEnv())
    #menv$latent$rw2$min.diff =1e-4
    # assign("inla.models", menv, INLA:::inla.get.inlaEnv() )
    h = 0.02
    while ( nw != nw0 ) {
      count = count + 1
      if (count > nmax ) break() # this is CPU expensive ... try only a few times

      FM = formula(  y ~ f( inla.group(xiid, n=inla.ngroups), model="iid")
                       + f( inla.group(x, n=inla.ngroups), model=inla.model )
                       )
      v = NULL
      v = try( inla( FM, data=z,
            control.predictor=list (compute=TRUE ),
            control.compute=list(config=TRUE),
            control.results=list(return.marginals.random=TRUE, return.marginals.predictor=TRUE ),
            control.inla = list( h=h ), # increase in case values are too close to zero
            # control.mode = list( restart=TRUE, result=v ), # restart from previous estimates
            quantiles=NULL,  # no quants to save storage requirements
            verbose=FALSE )
        , silent=TRUE )

      if ( "try-error" %in% class(v) ) next()

      # make sure Eigenvalues of Hessian are appropriate (>0)
      if ( v$mode$mode.status > 0 ) {
        h = h + 0.02
        next()
      }

      z$p = v$summary.fitted.values$mean
      rsq = cor( z$p, z$y, use="pairwise.complete.obs" )^2

      if (!is.na(rsq)) if (rsq > target.r2) break()

      # drop a few extreme data points and redo
      iid = v$summary.random$xiid[["mean"]]
      qiid = quantile( iid, probs=probs, na.rm=TRUE )
      i = which( iid > qiid[2] | iid < qiid[1] )
      if (length( i) > 0 ) z$y[i] = z$p[i]
      nw0 = nw
      nw = length( which(is.finite( z$y))) # to check for convergence
    }
    # return to original scale
    z$y = z$y + ymean
    z$p = z$p + ymean
  }


  if (method=="kernel.density") {
    # default method is kernel( "modified.daniell", c(2,1)),
    # a 2X smoothing kernel: 2 adjacent values and then 1 adjacent on the smoothed series .. i.e. a high-pass filter
    nd = length(smoothing.kernel$coef) - 1 # data points will be trimmed from tails so need to recenter:

    # test in case x increments are not uniform
    vv = unique( diff( z$x ) )
    xr = min(vv[vv>0])
    uu = unique( round( vv, abs(log10(xr))))
    if (length(uu) > 1 ) {
      # interpolate missing/skipped data before smoothing
      ifunc = approxfun( x= z$x, y=z$y, method="linear", rule=2 )
      r0 = range( z$x, na.rm=TRUE )
      fx = seq( r0[1], r0[2], by= min(uu) )
      fy = ifunc( fx)
    } else if (length(uu) ==1 ) {
      fx = z$x
      fy = z$y
    }
    fn = length( fx)
    si = (nd+1):(fn-nd)
    fp = rep( NA, fn)
    fp[si] = kernapply( as.vector(z$y), smoothing.kernel )


    pfunc = approxfun( x=fx, y=fp, method="linear", rule=2)
    z$p = pfunc( z$x)
    # plot( p ~ x, z, type="l" )

    # constrain range of predicted data to the input data range
    TR =  quantile( z$y, probs=probs, na.rm=TRUE  )
    toolow = which( z$p < TR[1] )
    if ( length(toolow) > 0 )  z$p[toolow] = TR[1]
    toohigh = which( z$p > TR[2] )
    if ( length(toohigh) > 0 ) z$p[toohigh] = TR[2]
    # lines( y ~ x, z, col="green" )
  }

  if (method=="tukey" ) {
    z$p =smooth( z$y )
  }



  if (method=="simple.linear") {
    pfunc = approxfun( x=z$x, y=z$y, method="linear", rule=2)
    z$p = pfunc( z$x)
  }


  if (method=="gam") {
    require(mgcv)
    gmod = gam( y ~ s(x) , data=z)
    z$p = predict( gmod, z, type="response" )
  }

  if (method=="smooth.spline") {
    # similar to inla .. duplicated x is problematic for smooth.spline ... add small noise
    nn = abs( diff( z$x) )
    dd = median( nn[nn>0], na.rm=TRUE )
    z$x = jitter( z$x, amount=dd / 20) # add noise as inla seems unhappy with duplicates in x?
    rsq = 0
    nw = length( which(is.finite( z$y)))
    nw0 = nw + 1
    count = 0
    while ( nw != nw0 ) {
      count = count + 1
      if ( count > nmax ) break()  # in case of endless loop
      uu = smooth.spline( x=z$x, y=z$y, keep.data=FALSE, control.spar=list(tol=dd / 20) )
      if ( length(uu$x) != nrow(z)  ) {
        afun = approxfun( x=uu$x, y=uu$y,  method="linear", rule=2  )
        vv = afun( z$x )
        z$p = vv$y
      } else {
        z$p = uu$y
      }
      rsq = cor( z$p, z$y, use="pairwise.complete.obs" )^2
      if (!is.na(rsq)){
        if (rsq > target.r2) break()
      }
      # drop a few extreme data points and redo
      iid = z$y - z$p
      qiid = quantile( iid, probs=probs, na.rm=TRUE )
      i = which( iid > qiid[2] | iid < qiid[1] )
      if (length( i) > 0 ) {
        z$y[i] = z$p[i]
      }
      nw0 = nw
      nw = length( which(is.finite( z$y))) # to check for convergence
    }
  }

  return(z$p)

}




