
  
  rename.variables = function(oldnames, lookupnames) {
    newnames = oldnames
    nvars = length(oldnames)
    for (i in 1:nvars) {
      j = which(lookupnames[,1] == oldnames[i])
      if (length(j)>0) newnames[i] = lookupnames[j,2]
    }
    
   return (newnames) 
  }


