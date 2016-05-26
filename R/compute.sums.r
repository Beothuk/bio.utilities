compute.sums = function (x, var, index) {
  res = as.data.frame.table( tapply( X=x[,var], INDEX=x[,index],
  	FUN=function(q) { sum(q, na.rm=T)}, simplify=T))
  for (i in index) { res[i,] = as.integer( res[i,] ) }
  return(res)
}

