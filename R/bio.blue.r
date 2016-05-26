
bio.blue <- function (n, alpha=1) { 
    if ((n <- as.integer(n[1])) > 0) { 
      blue = 4/6
      c( hsv( h = blue, 
              s = seq(0, 1, length = (n-1)), 
              v = 1, 
              alpha = alpha )
       ) 
    }
  }
   

