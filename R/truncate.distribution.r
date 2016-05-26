
      truncate.distribution = function( W, Ql, Qu ) {
        # the following truncates data to a range limited by quantiles or fixed limits
        Q = quantile( W, c(Ql, Qu), na.rm=T )
        j = which( W < Q[1] )
        k = which( W > Q[2] )
        if (length( j)>0 ) W[j] = Q[1]
        if (length( k)>0 ) W[k] = Q[2]
        return (W)
      }

