#' @export
#' @title convert.degdec2degmin
#' @description This function converts decimals to degree and minute notation
#' @param \code{x} = dataframe to be handled, with lat and lon colnames
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @examples
#' test=as.data.frame(cbind(42.5,55.255))
#' colnames(test)=c("lat","lon")
#' convert.degdec2degmin(test)
#' lat    lon
#' 1 42.3 55.153
#' (55.153 is 55deg 15.3min)
#' @family coordinate converters
#' @export
  convert.degdec2degmin = function (x) {
    x$lat = trunc(x$lat) + round(((x$lat - trunc(x$lat))/100) * 60, 6)
    x$lon = trunc(x$lon) + round(((x$lon - trunc(x$lon))/100) * 60, 6)
    return (x)
  }



