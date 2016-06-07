is.leap.year = function (yr) {
  #\\test to see if yr is a leap year
  yr%%4 == 0 & (yr%%100 != 0 | yr%%400 == 0 )
}

