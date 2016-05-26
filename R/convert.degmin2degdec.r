	
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


