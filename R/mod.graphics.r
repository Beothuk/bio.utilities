#' @title mod.graphics
#' @description converts all files in a directory from one type to another type for generic mapping routines
#' @family abysmally documented
#' @author unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  mod.graphics = function(variables, plottimes, outdir, outformat="") {

    for (v in variables) {
    for (t in plottimes) {

      dir = paste( outdir, t, v, sep="/" )
      print (dir)

      if ( length( grep("^ps", outformat, ignore.case=T) >=1)) {
        files = list.files( path=dir, pattern="[*.ps]$", all.files=T, full.names=T, recursive=F) 
      }
      if ( length( grep("^eps", outformat, ignore.case=T) >=1)) {
        files = list.files( path=dir, pattern="[*.eps]$", all.files=T, full.names=T, recursive=F) 
      }
      if ( length( grep("^png", outformat, ignore.case=T) >=1)) {
        files = list.files( path=dir, pattern="[*.png]$", all.files=T, full.names=T, recursive=F)
      }
      if ( length( grep("^jpg", outformat, ignore.case=T) >=1)) {
        files = list.files( path=dir, pattern="[*.jpg]$", all.files=T, full.names=T, recursive=F)
      }

      mod.graphics.basic (files, outformat)
     }}

   }


