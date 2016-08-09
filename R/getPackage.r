#' @title getPackage
#' @description load in package if not in lib need to put quotes around name
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
getPackage <- function(pkg){
  if(!require(pkg, character.only=TRUE)){
    install.packages(pkg, dependencies=TRUE)
     }  
  require(pkg, character.only=TRUE,quietly=T)
}