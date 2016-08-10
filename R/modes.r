#' @title modes
#' @description find the largest mode 
#' @family abysmally documented
#' @author unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
modes = function( Z, eps=0, ... ) {
  debug = FALSE
  if (debug) {
    # construct something that looks like a profile 
    Z = - 50 * cos( seq(-pi/2, pi/2, by=.02) )
    mid = trunc( length(Z) / 2 )
    Z = c( Z[1:mid], Z[mid] + ( runif( length(Z) )-0.5)*5, Z[mid:length(Z)] )  
    Z = max(Z) -Z
    plot(Z)
    modes( Z)
    kernal.bw.method="sj"
  }
 
  # kernel density based approach
  require(numDeriv)
 
  # simple determination from histogram
  Z = Z[ which(is.finite(Z) ) ]
  u = try( density(Z ) , silent = TRUE )
  if ("try-error" %in% class(u) )  {
    res = data.frame( mode=NA, sd=NA, lb=NA, ub=NA,lb1=NA,ub1=NA,lb2=NA,ub2=NA ) 
    rownames(res) = c("simple")
    return(res)
  }

  dZ  = numDeriv::grad( approxfun( u$x, u$y, rule=2 ), u$x, method="simple" )
  dZsm = interpolate.xy.robust( dZ, method="loess") 
  
  ddZ = numDeriv::grad( approxfun( u$x, dZsm, rule=2  ), u$x, method="simple" )     
  ddZsm = interpolate.xy.robust( ddZ, method="loess") 
  
  # inflection pts as lb, ub :: ddZ's maxima 
  # peak1 
  p1 = which.max( u$y )
  pl1 = which.max( dZsm )
  pr1 = which.min( dZsm )

  ddZ.med = median( ddZ)
  for ( p1lb in pl1:1) if ( ddZ[p1lb] >= eps ) break() # left
  for ( p1ub in pr1:length(ddZ) ) if ( ddZ[p1ub] >=  eps ) break() # right

      inflection.x = c( p1lb, p1ub ) 
      inflection.y = u$x[ inflection.x ]
      kd.mode = u$x[ p1 ]

  kd.sd0 = sd( Z[ Z > inflection.y[1] & Z < inflection.y[2] ] )

if(is.na(kd.sd0))   { #exception handling AMC Nov2.2015
  res = data.frame( cbind( mode=kd.mode, sd=NA, lb=NA, ub=NA,lb1=NA,ub1=NA,lb2=NA,ub2=NA )) 
return(res)
}

  # expand the are of interest before computing SD
  ylb = inflection.y[1] - kd.sd0
  yub = inflection.y[2] + kd.sd0

  kd.sd = sd( Z[ Z > ylb & Z < yub ] )

  res = data.frame( cbind( mode=kd.mode, sd=kd.sd, lb=ylb, ub=yub ))
  rownames(res) = c("kerneldensity")

  res$ub1 = res$ub + res$sd
  res$lb1 = res$lb - res$sd
  
  res$ub2 = res$ub + 2*res$sd
  res$lb2 = res$lb - 2*res$sd

  return(res)
}



