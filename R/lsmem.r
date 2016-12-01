lsmem = function() {
  sort( sapply(ls(),function(x){object.size(get(x))}))
}
