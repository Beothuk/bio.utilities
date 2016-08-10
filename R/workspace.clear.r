#' @title workspace.clear
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  workspace.clear = function() {

    lib.toclear = setdiff( search(),lib.init )
    if (length(lib.toclear) > 0) {
      for (pkg in lib.toclear ) detach( pos=match( pkg, search() ) )
    }
    rm ( lib.toclear)

    obj.toclear = setdiff( ls(), obj.init )
    try( rm( list=obj.toclear ), silent=T )
    rm (obj.toclear)

    namespace.toclear = setdiff( loadedNamespaces(), namespaces.init )
    try(unloadNamespace( namespace.toclear ), silent=T)
    rm (namespace.toclear)

    gc()

    cat( "Namespaces still in memory due to dependencies: \n")
    cat ( setdiff( loadedNamespaces(), namespaces.init ), "\n" )
  }



