
convert.datecodes = function (x, y) {
  # take a chron object x and extract required data
  require(chron)
  q = month.day.year(x)
  j = julian( x=q$month, d=q$day, y=q$year )
  z=NULL
  if (y=="chron") z = q
  if (y=="year") z = q$year
  if (y=="month") z = q$month
  if (y=="day") z = q$day
  if (y=="week") {
    z = round( convert.datecodes( x, y="julian" ) / 365 * 52) + 1
  }
  if (y=="julian") {
    z = j - julian(x=rep(1,length(q$year)), d=rep(1,length(q$year)), y=q$year)
    z = z + 1
    i = which(z > 365)
    z[i]= z[i] - 1
    j = which(z > 365)
    if ( length(j) > 1 ) print ("error in dates")
  }
  if (y=="julian.ref.2000") z = 1 + j - julian(x=rep(1,length(q$year)), d=rep(1,length(q$year)), y=rep.int(2000,length(q$year)))
  if (y=="tripcode") {
    day = as.character( convert.datecodes(x, "day") )
    day = ifelse( nchar(day) == 1, paste("0", day, sep=""), day)
    month =  as.character( convert.datecodes(x, "month") )
    month = ifelse( nchar(month) == 1, paste("0", month, sep=""), month)
    z = paste( "S", day,  month, convert.datecodes(x, "year"), sep="")
  }

  return (z)
}


