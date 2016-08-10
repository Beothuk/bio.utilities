#' @title loadPackages
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
loadPackages <- function(x) {
	  x <- as.character(substitute(x)) 
	  if(isTRUE(x %in% .packages(all.available=TRUE))) { 
	    eval(parse(text=paste("require(", x, ")", sep=""))) 
	  } else { 
	    update.packages() # recommended before installing so that dependencies are the latest version 
	    eval(parse(text=paste("install.packages('", x, "')", sep=""))) 
	  }
	  require(x)
	   
} 
