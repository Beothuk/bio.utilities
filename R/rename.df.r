
  rename.df = function(x, n0, n1) {
  	if(!length(n0)== length(n1)) stop('length of names and renames need to be the same length')
  	for(i in 1:length(n0)){
    	names(x)[which(names(x)==n0[i])] = n1[i]
		}
    return(x)
  }

