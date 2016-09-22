#' @title is_leap_year
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
is_leap_year = function (yr) {
  .Deprecated(msg="Why not use lubridate::leap_year() instead?")
  #\\test to see if yr is a leap year
  yr%%4 == 0 & (yr%%100 != 0 | yr%%400 == 0 )
}

