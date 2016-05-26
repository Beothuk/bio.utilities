
  Tabulate = function(f, data, varname="n") {
    xt = xtabs( f, data=data )
    out = as.data.frame.table( xt, responseName=varname )
    vars = all.vars(f)[-1]
    for (v in vars) out[,v] = as.character( out[,v] )
    out[,varname] = as.numeric( as.character( out[,varname] ) ) 
    return(out)
  }
   # ----------------------------------------

