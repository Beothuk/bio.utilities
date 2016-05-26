table.view = function( x ) {
    a = tempfile()
    write.table (x, file=a, sep=",")
    if(.Platform$OS.type == "unix") {
      b = try( system( paste( "libreoffice -calc", a) , wait=F )  )
      if ( b==0 ) return()
      b = try( system( paste( "gnumeric", a) , wait=F ) )
      if ( b==0 ) return()
      b = try( system( paste( "soffice -calc", a) , wait=F )  )
      if ( b==0 ) return()
      b = try( system( paste( "gvim" ,a  ) , wait=F ) )
      if ( b==0 ) return()
      b = try( system( paste( "firefox" ,a  ) , wait=F ) )
    } else {
      b = try( system(paste('"C:/Program Files/Microsoft Office/OFFICE10/EXCEL.EXE"', a ), wait=F) )
      if ( b==0 ) return()
      b = try( system(paste('"C:/Program Files/Microsoft Office/OFFICE11/EXCEL.EXE"', a ), wait=F) )
      if ( b==0 ) return()
      b = try( system(paste('"EXCEL.EXE"', a ), wait=F) )
      if ( b==0 ) return()
      b = try( system(paste('"C:/Program Files/Mozilla Firefox/Firefox.exe"', a ), wait=F) )
    }
    return("Done")
  }
  