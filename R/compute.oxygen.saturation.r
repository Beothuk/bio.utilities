
  compute.oxygen.saturation = function(t.C, sal.ppt, oxy.ml.l) {
    # formula attributed to Weiss DSR 17, 721-735, 1970
    t.K = t.C + 273.15
    o.ml.l.saturated = exp( -173.4292 + 249.6339 * (100/t.K) 
      + 143.3483*( log(t.K/100) ) 
      - 21.8492*(t.K/100) 
      + sal.ppt * (-0.033096 + 0.014259 * (t.K/100) - 0.0017*(t.K/100)^2 ) ) 
    
#  o.mg.l.saturated = o.ml.l.saturated * 32/22.414
    
    DO = oxy.ml.l / o.ml.l.saturated * 100
    return(DO)
  }


