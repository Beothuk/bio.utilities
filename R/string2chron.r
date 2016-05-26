
  string2chron = function(u, informat=c(dates="year-m-d", times="h:m:s"), outformat=c(dates="year-m-d", times="h:m:s") ) {
    # convert a string representation of chron into a chron object
    require (chron)
    u = gsub("[()]", "", u)
    ii = which( is.na(u) )
    jj = which( ! is.na(u) )
    if (length (ii) > 0) u[ii] = "NA NA" # force a double NA entry to allow parsing below
    out = rep( NA, length(u) )  # initiate output vector 
    y = matrix(unlist(strsplit(u, " ")),ncol=2,byrow=T)
    out[jj] = chron( dates(y[jj,1], format=informat[1]), times(y[jj,2],format=informat[2]) )
    out = as.chron(out, out.format=outformat )
    return(out)
  }



