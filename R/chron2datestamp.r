#' @export
#' @title chron2datestamp
#' @description This function converts dates from \code{chron::} format and append the time as a fraction, for use as a timestamp  
#' @param \code{x} = the date
#' @param \code{res} = the time will be calculated as a fraction of this value (defaults to \code{12})
#' @return character vector
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @examples
#' require(chron)
#' t1<- chron(dates =  dates(c("02/27/92")), times =  "08:00:00")
#' chron2datestamp(t1,100)
#' [1] "02/27/92.33"
#' 
#' t2<- chron(dates =  dates(c("02/27/92")), times =  "12:00:00")
#' chron2datestamp(t2,10)
#' [1] "02/27/92.5"
#' @family date functions
#' @export
  chron2datestamp = function(x, res=12) {
    ds = paste( dates(x),
                round(res*(hours(x)+minutes(x)/60+seconds(x)/60/60)/24),
                sep="." )
    return(ds)
  }


