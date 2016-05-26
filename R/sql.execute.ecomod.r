
  sql.find.ecomod = function( sql, loc="default" ) {
    
    # find matching SQL in a given localtion and execute
 
    example.usage = FALSE 
    if (example.usage) {
      sqlcmd = sql.find.ecomod( "GSINF_VIEW" )

      require (RODBC)
      con <- odbcConnect(" ... ")
        sqlQuery( con, sqlcmd )
      close(con)
      # .. any other manipulations within R ..
      # sqlSave( con, whatever, ... ) or save locally, etc ..
    }

   
    if (loc=="default") {
      loc = project.codedirectory( "oracle.objects", "src", "sql") 
    }
    
    flist = list.files( path=loc, pattern="*.sql", recursive=TRUE, ignore.case=TRUE ) 
    fl = basename(flist)


    i = grep( sql, fl ) 

    if (length(i) != 1) {
      print( "No exact match found" )
      print( "Here are the closest matches: ") 
      i = pmatch( sql, fl )
      print( flist[ i]  )
      stop()
    }

    sqlcmd = readLines( file.path( loc,  flist[i] ) )

    # clean the sql 
    comments = grep( "--.*$", sqlcmd )
    sqlcmd = sqlcmd[- comments ]

    return( paste( sqlcmd, collapse=" " ) )

  }

 
