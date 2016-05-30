
parallel.run = function( FUNC, p, export=NULL, rndseed = 1, specific.allocation.to.clusters=F,... ) {
  # expectation of all relevant parameters in a list 'p'

  require(parallel)

  res = with( p, {
    if (!exists("clusters")) {
      k = detectCores()
      clusters = "localhost"
      print( paste( "Using serial mode as no clusters were defined.", k, "cores are found on localhost, Define 'p$clusters' if you wish to run in parallel mode." ))
    }
    if (!exists("clustertype")) {
      clustertype = "PSOCK"
      print( paste( "Using", clustertype, "connections as default, 'clustertype' was not defined." ))
    }
    if (!exists("rndseed")) {
      print( paste( "Using", rndseed, "as the default random number seed for parallel operations, Specify 'rndseed' to change." ))
    }
    if (!exists("nruns")) stop( "Must define 'nruns' in the paramater list")
    
    if ( length(clusters) == 1 ) {
      out = NULL
      out = FUNC( p=p, ... ) 
      return(out)
    }
    
    if ( length(clusters) > 1 ) {

      cl = makeCluster( spec=clusters, type=clustertype ) # SOCK works well but does not load balance as MPI 
      RNGkind("L'Ecuyer-CMRG")  # multiple streams of pseudo-random numbers.
      
      clusterSetRNGStream(cl, iseed=rndseed )

      if ( !is.null(export)) clusterExport( cl, export )
     
      # define allocation of runs to clusters
      if ( !specific.allocation.to.clusters ) {
        # default is a simple split
        ssplt = lapply( clusterSplit( cl, 1:nruns ), function(i) i )
      } else {
        # split runs by species or area to collect analysis on a single aspect together for saving
        uv = unique(p$runs$v)
        uvl = length(uv)
        lc = length(p$clusters)
        lci = 1:lc
        ssplt = list()
        for(j in 1:uvl) {
          ssplt[[j]]  = which(p$runs$v == uv[j])
        }
        ssplt2 = rep(list(numeric()),lc)
        if(uvl>lc) { 
          for(j in 1:uvl) {
            k=j
            if(j>lc) k = j%%lc+1
            ssplt2[[k]] <- c(ssplt2[[k]],ssplt[[j]])
          }
        }
        ssplt = ssplt2
      }

      out = NULL
      out = clusterApply( cl, ssplt, FUNC, p=p, ... )
      stopCluster( cl )   
      return( out )  
    }
  })

  return( res )
}
