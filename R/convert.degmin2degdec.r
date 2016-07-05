#' @export
#' @title convert.degmin2degdec
#' @description This function converts coordinates in dd.mmmm to decimal degrees
#' @param \code{x} = dataframe to be handled, with lat and lon colnames
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @examples
#' test=as.data.frame(cbind(-52.3050,55.20))
#' colnames(test)=c("lat","lon")
#' convert.degmin2degdec(test)
#' lat      lon
#' 1 -52.50833 55.33333
#' @family coordinate converters
#' @export	
  convert.degmin2degdec = function (x, y=NULL, vnames=c("lon", "lat") ) {
    xlon = x[,vnames[1]]
    xlat = x[,vnames[2]]
    if (is.null(y)) {
      x[,vnames[1]] = trunc(xlon) + round((xlon - trunc(xlon)) /60 * 100, 6)
      x[,vnames[2]] = trunc(xlat) + round((xlat - trunc(xlat)) /60 * 100, 6)
    } else {
      if (y=="lon") x = - (floor(x/100)+(x-100*floor(x/100))/60)
      if (y=="lat") x = floor(x /100)+(x - 100*floor(x /100))/60
    }
    return (x)
  }


