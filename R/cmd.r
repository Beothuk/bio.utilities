#' @export
#' @title cmd
#' @description This facilitates invoking system commands directly
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export 
cmd = function(x, ...) { system(paste(x, ...)) }

