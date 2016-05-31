

# working with time and dates in R

# Core functionality is based upon POSIX standards
?POSIXt

Class ‘"POSIXct"’  -- time since 1970 -- in seconds

Class ‘"POSIXlt"’  -- time stamp in human readable format

Example:

    z.ct <- Sys.time()             # the current date, as class "POSIXct"
    print(z.ct)
    unclass( z.ct )  # seconds since 1970-1-1 00:00:00 
 
    z.lt = as.POSIXlt( z.ct, "AST" ) # the current time in Atlantic time zone
    z.lt = as.POSIXlt( z.ct, "GMT" ) # the current time in GMT
    print(z.lt)
    unclass( z.lt )  # human readable characters
    unclass( as.POSIXct( z.lt) ) # return to numeric format (seconds)

    # pretty print in human readable format
    format(z.lt)
    format(z.ct) 

    months(z.ct)
    julian(z.lt)


# operating with POSIX .. a bit convoluted:
    date = as.POSIXct("01-01-2010", format = "%d-%m-%Y", tz = "UTC")
    as.POSIXlt(date)$month + 1
    as.numeric(format(date, "%m"))  
    date = as.POSIXct(format(date,"%Y-2-%d"), tz = "UTC")
    as.POSIXct(format(as.POSIXct(date), tz = "UTC"), tz = "GMT") 


# lubridate interoprates with POSIX as well as a number of other different formats and is fast
# install.packages( "lubridate")  # if you do not have it
  library(lubridate) 


    date = dmy("01-01-2010")
    month(date)
    month(date) = 2
    with_tz(date, "GMT")

#Parsing .. reading in dates
    mdy("12-01-2010")
    ydm("2010-01-01")

    dmy(c("31.12.2010", "01.01.2011", "12-01-2010", "12:06.2070"  ))  # kind of smart
    
    z = now()
    year(z) 
    minute(z)

    year(z) = 2121
    day(z) = day(z) + 3

    z = z + hours(3)


    z = ymd_hms("2012-01-01 12:00:00")
    a = ymd_hms("2013-05-05 12:00:00")

    b = z- a
    unclass(b)




