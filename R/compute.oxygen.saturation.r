#' @export
#' @title compute.oxygen.saturation
#' @description This function determines the percentage of Dissolved oxygen in solution at a given temperature and salinity given a known saturation amount. formula attributed to Weiss DSR 17, 721-735, 1970
#' @param \code{t.C} = temperature in Celsius
#' @param \code{sal.ppt} = salinity in ppt
#' @param \code{oxy.ml.l} = oxygen saturation in ml/L
#' @return \code{DO} = saturation percentage
#' @examples
#' compute.oxygen.saturation(0, 25, 8.2)
#' [1] 95.19575
#' @family physical and chemical properties
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  compute.oxygen.saturation = function(t.C, sal.ppt, oxy.ml.l) {
    warning('MMM - 2016-06-17 - Please ensure this works correctly - I was unable to replicate values from online calculators')
    t.K = t.C + 273.15
    o.ml.l.saturated = exp( -173.4292 + 249.6339 * (100/t.K) 
      + 143.3483*( log(t.K/100) ) 
      - 21.8492*(t.K/100) 
      + sal.ppt * (-0.033096 + 0.014259 * (t.K/100) - 0.0017*(t.K/100)^2 ) ) 
    
#  o.mg.l.saturated = o.ml.l.saturated * 32/22.414
    
    DO = oxy.ml.l / o.ml.l.saturated * 100
    return(DO)
  }


