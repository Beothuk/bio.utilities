#' @title fix.permissions
#' @description File permissions can get messed up easily in a shared environment, make permissions sensisble recursively inside directory "loc"
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  fix.permissions = function( loc=bio.datadirectory, file.perm="ugo+rw", dir.perm=" ugo+rwx", method="unix" ) {
    if (method=="unix") {
      if ( tolower( Sys.info()["sysname"] ) != "linux" ) stop( "This is for unix systems only" )
      print( paste( "Operating upon ... ", loc ) )
      # system ( paste( "sudo chown -R 1001:1000", file.path(loc, "") ) ) # bio user id = 1001. bio group = 1000
      system ( paste( "find", file.path(loc, ""), 
        "\\( -type f -exec chmod", file.perm, " {} \\; \\) ,",
        "\\( -type d -exec chmod", dir.perm, " {} \\; \\) " 
      ))
    }

    if (method =="R" ) {
      # does not work ?? .. not sure why .. left here in case someone wants to try to use this method 
      # still interfaces with chmod so I do not see the point, but a useful example [jae]
      if ( tolower( Sys.info()["sysname"] ) != "linux" ) stop( "This is for unix systems only" )
      dirs = list.dirs(loc, full.names = TRUE, recursive = TRUE)
      files = list.files(loc, all.files=TRUE, full.names=TRUE, recursive=TRUE, include.dirs=TRUE)
      Sys.chmod( dirs, "+0775" )
      Sys.chmod( files, "664" )
    }


  }



