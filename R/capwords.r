#' @export
#' @title capwords
#' @description This function capitalizes words 
#' @param \code{s} = the string to handle
#' @param \code{strict} = if \code{TRUE}, forces capitalization of all words (as long as \code{sentence = F})
#' @param \code{sentence} = if \code{TRUE}, only the first word is capitalized
#' @return character vector
#' @note taken from help of 'toupper' 
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @examples
#' capwords('this is a test', F, T)
#'[1] "This is a test"
#' capwords('this is a test', T, T)
#'[1] "This is a test"
#' capwords('this is a test', T, F)
#'[1] "This Is A Test"
#' capwords('this is a test', F, F)
#'[1] "This Is A Test"
#' @export
capwords <- function(s, strict = FALSE, sentence=T) {
	cap <- function(s) paste(toupper(substring(s, 1, 1)),
                       {s <- substring(s, 2); if(strict) tolower(s) else s},
                                  sep = "", collapse = " " )
	if(sentence){
		sapply(s, cap, USE.NAMES = !is.null(names(s)))
	} else {
		sapply(strsplit(s, split = " "), cap, USE.NAMES = !is.null(names(s)))
	}
}
