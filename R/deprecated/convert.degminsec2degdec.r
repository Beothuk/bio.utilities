#' @title convert.degminsec2degdec
#' @description This function converts degminsec to decimal degrees
#' @param \code{z} = = dataframe to be handled, with lat and lon colnames
##' @return \code{res} = saturation percentage
#' @examples
#' @notes MMM - 2016-06-16 - marking as deprecated.  While documenting, I noticed that it makes small errors with the minutes.
#' @family coordinate converters
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  convert.degminsec2degdec = function (z) {
    .Deprecated()
	z = z/10000
    degrees = trunc( z ) 
	zm = (z - degrees )  * 100
	minutes = trunc (zm )
	seconds = (zm - minutes) * 100
	res = degrees + minutes / 60 + seconds / 60 /60
	browser()
    return (res)
  }


