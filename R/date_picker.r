#' @export
#' @title date_picker
#' @description This function presents successive picklists for year, month and day, and returns a date.  The original purpose of this function is to provide a means to select valid dates for use in modifying SQL queries on demand.
#' @note Only valid days for each month and year combo are presented.  Most complexity is due to the potential for users to click cancel rather than choose valid options.  Cancelling at any point fails gracefully, and results will depend on the selected parameter.   
#' @param \code{type} valid values include "presets" (for quickly getting the date from a year ago, 6 months ago, etc), "default" or "start"  (any time the user cancels the dialog boxes, it defaults to the earliest date corresponding to the users selections), or "end"  (any time the user cancels the dialog boxes, it defaults to the latest available date corresponding to the user's selections)
#' @return \code{the.date} returns a date in the format "YYYY-MM-DD" 
#' @author Mike McMahon, \email{Mike.McMahon@@dfo-mpo.gc.ca}
#' @family date functions
#' @export
date_picker<-function(type="default"){
   if (type=="start" | type=="default"){
    type="default"
    titletweak="the Earliest"
  }else if (type=="end"){
    titletweak="the Most Recent"
  } 
  the.year=NULL
  the.month=NULL
  the.day=NULL
  date.format="%Y-%m-%d"
  if (type=="presets"){
    date.1<-select.list(c("One year ago",
                          "Six months ago",
                          "Today"),
                          multiple=F, graphics=T, 
                          title=("Preset Dates"))
    if(date.1=="One year ago"){
      the.date=format(seq(Sys.Date(), length=2, by="-1 years")[2] - 1, date.format)
    }else if (date.1=="Six months ago"){
      the.date=format(seq(Sys.Date(), length=2, by="-6 months")[2] - 1, date.format)
    }else if (date.1=="Today"){
      the.date=format(Sys.Date(), date.format)
    }else if (date.1==""){
      the.date=format(Sys.Date(), date.format)
    }
  }else{
    years<-c(format(Sys.Date(), "%Y"):1977)
    months<-c(1:12)
    def.year<-max(years)
    if (type=="end"){
      def.month<-12
    }else {
      def.month<-1
    }
    the.year<-select.list(as.character(years),
                          multiple=F, graphics=T, 
                          title=paste0("Select ",titletweak," Year"))
      if (the.year=="") {
        the.year=def.year 
        the.month=def.month 
        if (type=="default"){
          the.day=1 
        }else if (type=="end"){
          the.day=max(get.day(the.year,the.month))
        }
      }else {
        the.month<-select.list(as.character(months),
                               multiple=F, graphics=T, 
                               title=paste0("Select ",titletweak," Month"))
        if (the.month=="") {
          the.month=def.month 
          all.days=get.day(the.year,the.month)
          if (type=="default"){
            the.day=1 
          }else if (type=="end"){
            the.day=max(get.day(the.year,the.month))
          }
          
        }else{
          the.day<-select.list(as.character(get.day(the.year,the.month)),
                               multiple=F, graphics=T, 
                               title=paste0("Select ",titletweak," Day"))
          if (the.day=="") {
            all.days=get.day(the.year,the.month)
            if (type=="default"){
              the.day=1 
            }else if (type=="end"){
              the.day=max(get.day(the.year,the.month))
            }
        }
      }
    }
  the.date=format(as.Date(paste(the.year,the.month,the.day,sep="-")), date.format)
  }
return(the.date)  
}