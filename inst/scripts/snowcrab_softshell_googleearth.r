
  # read in soft-shell data ( SQL	or from a datadump )
  # SELECT * FROM SNOWCRAB.SOFT_SHELL_REPORTS where landing_date > '01-JAN-2009'
  # "Note: If more than 1 map was generated, these extraction includes the data for all of the maps"
  # TRIP	LANDING_DATE	LATITUDE	LONGITUDE	NSAMPLED	NSOFT_SHELL	CATCH_RATE_KG_PER_TRAP


  # can also fetch this directly from Oracle using an RODBC connection:
  # require (RODBC)
  # con = ... etc
  # ss = sqlQuery() ...

  bioLibrary( "bio.utilities" )

  workdir = getwd()


  redo.background.kml = F
  if ( redo.background.kml ) {
    # make snow crab background layers to a separate file
    backgroundfile = file.path( workdir, "snowcrab_layers.kml" )
    kml.snowcrab.background( backgroundfile )
  }


  outfile =  file.path( workdir, "softshell_report.kml" )
  fn = file.path( workdir, "softshell_report.csv")

  ss = read.table( fn )
  names( ss) = tolower( c( "TRIP", "LANDING_DATE", "LATITUDE", "LONGITUDE", "NSAMPLED", "NSOFT_SHELL" ))
  ss$pr.soft = round( ss$nsoft_shell / ss$nsampled * 100  )
  ss = ss[ order( ss$pr.soft, decreasing=T ) ,]

  low = which( ss$pr.soft < 20 &  ss$pr.soft > 10 )
  high = which( ss$pr.soft >= 20 )
  ss$softshell.category =  NA
  ss$softshell.category [ low ] = "low"
  ss$softshell.category [ high ] = "high"

  resolution = 2  # 2 -minute squares

  ss$lon.min = (ss$longitude - trunc( ss$longitude  ) ) *60
  ss$lon.min = trunc( ss$lon.min / 2 ) * 2 # round to 2-min resolution
  ss$longitude = round( trunc(ss$longitude) + ss$lon.min / 60 , 2 )
  ss$elevation = 0
  ss$elevation[low] = 1
  ss$elevation[high] = 2  # these are used to force the high values to be displayed on "top" of the lower

  ss$lat.min = (ss$latitude - trunc( ss$latitude  ) ) *60
  ss$lat.min = trunc( ss$lat.min / 2 ) * 2 # round to 2-min resolution
  ss$latitude = round( trunc(ss$latitude) + ss$lat.min / 60, 2)
  ss$desc = paste(
              "Date:", ss$landing_date, "\n",
              "Lon / Lat:", ss$latitude, "/",  ss$longitude, "\n",
              "Soft-shell crab:", ss$pr.soft, "%" )

  coords = c("longitude", "latitude", "elevation")

   # start kml document
  con = kml.start( outfile, "softshell_report" )

    # define point styles/colours, etc
    kml.placemark.make( con, item="style", style.id="pin.red", colour="c0ffffff", scale=0.30,
      href='http://nssnowcrab.googlepages.com/reddot.png' )  # red dot
    kml.placemark.make( con, item="style", style.id="pin.yellow", colour="a0ffffff", scale=0.25,
      href='http://nssnowcrab.googlepages.com/yellowdot.png' )  # yellow dot

    # main folder start
    kml.folder.start( con, folder.name="Scotian Shelf snow crab soft-shell incidence",
      desc="Asssessment tools for the Scotian Shelf snow crab (Bedford Institute of Oceanography)"
    )

        kml.folder.start( con, "10% to 20% soft" )
          for ( i in low ) { # low defined at top
            kml.placemark.make( con, desc=ss[i,"desc"], style.id="pin.yellow", x=ss[i, coords] )
          }
        kml.folder.end( con )

        kml.folder.start( con, "Greater than 20% soft" )
          for ( i in high ) { # high defined at top
            kml.placemark.make( con, desc=ss[i,"desc"], style.id="pin.red", x=ss[i, coords] )
          }
        kml.folder.end( con )

    kml.folder.end( con )
  kml.end( con )


  print( "Google earth file has been completed and saved as the following: ")
  print( outfile )




