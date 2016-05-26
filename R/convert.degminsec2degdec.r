
  convert.degminsec2degdec = function (z) {
	z = z/10000
    degrees = trunc( z ) 
	zm = (z - degrees )  * 100
	minutes = trunc (zm )
	seconds = (zm - minutes) * 100
	res = degrees + minutes / 60 + seconds / 60 /60
    return (res)
  }


