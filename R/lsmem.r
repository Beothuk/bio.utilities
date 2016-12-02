lsmem = function() { as.matrix(sort( sapply(ls(envir=globalenv()),function(x){object.size(get(x))})) ) }

