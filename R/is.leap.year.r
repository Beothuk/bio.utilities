#' @title is.leap.year
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
is.leap.year = function (yr) {
  #\\test to see if yr is a leap year
  yr%%4 == 0 & (yr%%100 != 0 | yr%%400 == 0 )
}

