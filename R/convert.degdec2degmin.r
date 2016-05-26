  # convert decimals to degree and minute notation

  convert.degdec2degmin = function (x) {
    x$lat = trunc(x$lat) + round(((x$lat - trunc(x$lat))/100) * 60, 6)
    x$lon = trunc(x$lon) + round(((x$lon - trunc(x$lon))/100) * 60, 6)
    return (x)
  }



