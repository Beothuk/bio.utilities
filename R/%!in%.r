#' "%!in%"
#' @param x numeric
#' @param y numeric
#' @examples
#' c(1,3,11) %!in% 1:10
#' @export

"%!in%" <- function(x,y) {
	x = !('%in%'(x,y))
	x

}