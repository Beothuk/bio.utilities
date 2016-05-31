

  # private passwords, etc in .Rprofile

	oracle.personal.user = "myuserid"
  oracle.personal.password = "mypasswd"
	oracle.snowcrab.user = "mysnowcrabid"
  oracle.snowcrab.password = "mysnowcrabpasswd"
  
  
  logbook.db (DS="odbc.logbook", yrs=1990:2015) -> k


  # example

  logbook.db = function( DS, yrs=NULL, speciesids=705 ) {
    		
		if (DS %in% c("odbc.logbook", "odbc.logbook.redo")) {
			
	  	if (DS == "odbc.logbook.redo") {
      
        fn.root =  file.path( project.directory("snowcrab"), "data", "logbook", "datadump" )
        
        dir.create( fn.root, recursive = TRUE, showWarnings = FALSE )
          
        require(RODBC)

        con = odbcConnect( oracle.snowcrab.server, 
          uid=oracle.snowcrab.user, pwd=oracle.snowcrab.password, believeNRows=F)
      
        for ( YR in yrs ) {
          fny = file.path( fn.root, paste( YR,"rdata", sep="."))
          logbook = NULL
          for (speciesid in speciesids ){

            query = paste(
              "SELECT * from marfis.marfis_crab ", 
              "where target_spc=", speciesid ,
              "AND EXTRACT(YEAR from DATE_LANDED) = ", YR 
            )
            
            res = sqlQuery(con, query )

            if (!is.null (res) ) logbook = rbind( logbook, res) 
          }

          save( logbook, file=fny, compress=T)
          gc()  # garbage collection
          print(YR)
        }
        odbcClose(con)
        return (yrs)
      }
      
      #  -------------------

			if (DS=="odbc.logbook") {
				out = NULL
				for ( YR in yrs ) {
					fny = file.path( fn.root, paste( YR, "rdata", sep="."))
					if (file.exists(fny)) {
						load (fny)
						out = rbind( out, logbook )
					}
				}
				return (out)
			}
         
			
		}

 n <- 17; fac <- factor(rep(1:3, length = n), levels = 1:5)
     table(fac)
     tapply(1:n, fac, sum)
     tapply(1:n, fac, sum, simplify = FALSE)
     tapply(1:n, fac, range)
     tapply(1:n, fac, quantile)
     

