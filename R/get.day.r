#' @title get.day
#' @description This function provides the number of days in each month, given a year and month. This script was originally part of the date.picker() function, but was separated since it might be useful on its own
#' @note It accounts for leapyears from 1904-2096.  Leapyears are not simply every 4 years - please look it up should this script live long enough to need modification 
#' @param \code{the.year} YYYY
#' @param \code{the.month} MM
#' @author Mike McMahon, \email{Mike.McMahon@@dfo-mpo.gc.ca}
#' @family date functions
#' @export
get.day<-function(the.year,the.month){
  leapyears = seq(1904, 2096, 4 )
  if (the.month %in% c(1,3,5,7,8,10,12)){
    the.days = c(1:31)
  }  else if (the.month %in% c(4,6,9,11)){
    the.days = c(1:30)
  } else if (the.year %in% leapyears){
    the.days = c(1:29)
  }else{
    the.days = c(1:28)
  }
  return(the.days)
}