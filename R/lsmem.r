#' @title lsmem
#' @description list memory usage of user workspace
#' @family abysmally documented
#' @author jae, \email{jae.choi@dfo-mpo.gc.ca}
#' @export

lsmem = function() { as.matrix(sort( sapply(ls(envir=globalenv()),function(x){object.size(get(x))})) ) }

