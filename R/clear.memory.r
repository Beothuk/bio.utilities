#' @export
#' @title clear.memory
#' @description This function clears all data sets and functions defined in the current environment
#' @note taken from help of 'toupper' 
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
clear.memory = function() {
  to.remove = ls()
  rm( list=to.remove )
}

