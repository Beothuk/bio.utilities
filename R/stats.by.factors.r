#' @title stats.by.factors
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
stats.by.factors = function( x, factors ) {

  omean = as.data.frame.table( tapply( x, factors, FUN=mean, na.rm=T,simplify=T ) )
  names(omean)[which(names(omean)=="Freq")] = "mean"

  osd = as.data.frame.table( tapply( x, factors, FUN=sd, na.rm=T,simplify=T ) )
  names(osd)[which(names(osd)=="Freq")] = "sd"

  oN = as.data.frame.table( tapply( x, factors, FUN=function(o) {length(which(is.finite(o)))}, simplify=T ) )
  names(oN)[which(names(oN)=="Freq")] = "n"

  out = merge(omean, osd, by=names(factors), all=T, sort=F)
  out = merge(out, oN,  by=names(factors), all=T, sort=F)
  out$se = out$sd/sqrt(out$n-1)

  return (out)
}



