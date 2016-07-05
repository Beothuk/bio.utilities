#' @export
#' @title cap
#' @description This function ensures that the passed string gets a capitalized letter 
#' @param \code{s} = the string to handle
#' @param \code{strict} = if \code{TRUE}, removes all other uppercase letters; if \code{FALSE} (the default), ignore subsequent capitals
#' @return character vector
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @examples
#' cap('this is a TEST', F)
#' [1] "This is a TEST"
#' cap('this is a TEST', T)
#' [1] "This is a test"
#' @export
cap = function(s, strict=FALSE) {
    paste( toupper(substring(s,1,1)), 
           { s <- substring(s,2); if(strict) tolower(s) else s},
           sep = "", collapse = " " 
		)
}


