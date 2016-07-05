#' @export
#' @title dayofyear
#' @description This function converts dates from \code{chron::} format into the day number of year
#' @param \code{t} = the date
#' @return = the numerical day of the year
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @examples
#' dayofyear("2016-02-11")
#' [1] 42
#' @family date functions
#' @export
 dayofyear = function(a) {
  lubridate::yday(a)
 }

