 
  variable.recode = function( x, variable, direction="forward", db="snowcrab", rm.na=F ) {

    #  load transformation tables associated with a given variable 
    tl = lookup.datatransformation(db) 

    if (file.exists( tl$repository) ) {
      load (tl$repository)
    } else {
      REPOS = recode.variable.initiate.db ( db )
    }
    
    ii = which( REPOS$varname == variable )
    if (length(ii) == 0 ) { # missing from list .. print error message and stop to figure out why
      print( paste("Recode:", variable, "is missing from database, assuming no transformation"))
      # tmp = REPOS[1,]
      # tmp[1,] = c(variable, "none", 0, 1 )
      return( x ) 
    } else if ( length(ii) > 1 ) { 
      print(paste( "Error in recode:", variable, "has too many incidences in database"))
      stop()
    } 
    
    TF = REPOS[ii ,] 
    if ( TF$transform %in% c("", "none") ) {
      B = x
    }
 
    if ( TF$transform == "log10") {
      if (direction =="forward") {
        B = log10( x + TF$offset )
      } else if (direction =="backward") {
        B = 10^x - TF$offset
      }
    }

    if ( TF$transform == "scaled+centered") {
      if (direction =="forward") {
        B = scale( x, center=TF$offset, scale=TF$scaling )
      } else if (direction=="backward" ) {
        B = fields::unscale( x, x.center=TF$offset, x.scale=TF$scaling )
      }
    }

    if (rm.na) B = B[which(is.finite(B))]
    
    return (B)
  }


