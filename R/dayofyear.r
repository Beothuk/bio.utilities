
 dayofyear = function(a) {
  #\\ convert a timestamp (a) to day number of year
  # (lubridate::decimal_date(a) - lubridate::year(a) ) * 365.242189
  lubridate::yday(a)
 }

