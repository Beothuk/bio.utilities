% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/date_picker.r
\name{date_picker}
\alias{date_picker}
\title{date_picker}
\usage{
date_picker(type = "default")
}
\arguments{
\item{\code{type}}{valid values include "presets" (for quickly getting the date from a year ago, 6 months ago, etc), "default" or "start"  (any time the user cancels the dialog boxes, it defaults to the earliest date corresponding to the users selections), or "end"  (any time the user cancels the dialog boxes, it defaults to the latest available date corresponding to the user's selections)}
}
\value{
\code{the.date} returns a date in the format "YYYY-MM-DD"
}
\description{
This function presents successive picklists for year, month and day, and returns a date.  The original purpose of this function is to provide a means to select valid dates for use in modifying SQL queries on demand.
}
\note{
Only valid days for each month and year combo are presented.  Most complexity is due to the potential for users to click cancel rather than choose valid options.  Cancelling at any point fails gracefully, and results will depend on the selected parameter.
}
\seealso{
Other date functions: \code{\link{chron2datestamp}},
  \code{\link{convert.datecodes}}, \code{\link{dayofyear}},
  \code{\link{get.day}}, \code{\link{get_day}}
}
\author{
Mike McMahon, \email{Mike.McMahon@dfo-mpo.gc.ca}
}
