# **[get.day.r](../../src/_RFunctions/bio.utilities/datetime/get.day.r)**
#### MMM - Jan 2016 
This function provides the number of days in each month, given a year and month.  It accounts for leapyears from 1904-2096.  Leapyears are not simply every 4 years - please look it up should this script live long enough to need modification :)

This script was originally part of the [date.picker()](../../src/_RFunctions/bio.utilities/datetime/date.picker.r) function, but was separated since it might be useful on its own
 
```R
#how many days in February, 1976?
get.day(1976,2)
 [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29
```

