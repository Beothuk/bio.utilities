### - function to capitalize words 
# taken from help of 'toupper'

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
