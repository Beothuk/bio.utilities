
  Rsquared.lm = function(o) {
    R2 <- summary(o)$r.squared
    names(R2) <- 'Rsquared'
    R2
  }
 
