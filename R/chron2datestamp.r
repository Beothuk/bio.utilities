  chron2datestamp = function(x, res=12) {
    ds = paste( dates(x),
                round(res*(hours(x)+minutes(x)/60+seconds(x)/60/60)/24),
                sep="." )
    return(ds)
  }


