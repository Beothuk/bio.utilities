  recode.variable.initiate.db = function( db ) {
    
    tl = lookup.datatransformation( db )
    
    REPOS = NULL
  
    dataset.names = c(names( tl$set),names(tl$logs))

    for (si in 1:length(tl$sn)) {
      transform = offset = scaling =NA
      varname = tl$sn[si]
      if (! varname %in% dataset.names ) next()
      if(varname %in% names(tl$set))  x = tl$set[, varname]
      if(varname %in% names(tl$logs)) x = tl$logs[, varname]
      if (varname %in% tl$log.transform) {
        transform="log10"
        offset = offset.determine(x)
      } else if (varname %in% tl$scaled.centered) {
        transform = "scaled+centered"
        y = scale( x )
        offset = attr(y,"scaled:center") # mean
        scaling = attr(y,"scaled:scale") # RMS error  .. i.e. a Z-transform
      } else {
        transform = "none"
        y = x 
        offset = 0 
        scaling = 1 
      }
      # add more as needed
      REPOS = rbind( REPOS,  cbind( varname, transform, offset, scaling  ) 
      )
    }
    REPOS = data.frame( REPOS, stringsAsFactors=F )
    REPOS$offset = as.numeric(REPOS$offset)
    REPOS$scaling = as.numeric(REPOS$scaling)
     
    loc = dirname( tl$repository )
    dir.create( path=loc, recursive=T, showWarnings=F )
    save( REPOS, file=tl$repository )
    return( REPOS )
  }



