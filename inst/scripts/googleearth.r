
  # example to create a googlearth file adding points ("placemarks")

	bioLibrary("bio.utilities")


	# define workspace appropriate files and directories
	workdir = file.path( "C:", "base of googleearth file directory", "" )
  outfile = file.path( workdir, "my.googleearth.report.kml" )

	# bring in the data to plot
  data.to.plot = read.table( fn ) # require lon,lat and variable(s) to plot
	data.to.plot$elevation = 0  # arbitrary but can be informative

	locations.1 = which( data.to.plot$catch.rate < 100 )  # arbitary example

  # start kml document

		# define a file connection
    con = kml.start( outfile, "Name of My KML document" )

      # define point styles/colours, etc: "style.id", color codes in hexadecimal notation: transparency|R|G|B
      kml.placemark.make( con=con, item="style", style.id="yellow.pin", colour="ff00ffff", scale=0.5, href='' )  # yellow pushpin
      kml.placemark.make( con=con, item="style", style.id="test2.pin", colour="ff0000ff", scale=0.5, href='' )
      kml.placemark.make( con=con, item="style", style.id="test1.pin", colour="ff00ff00", scale=0.5, href='' )

      # start initial folder of points
      kml.folder.start( con, "My first folder" )

        for ( i in locations.1 ) {
					# paste a series of points into the kml
          kml.placemark.make( con=con, style.id="yellow.pin", data.to.plot[i, c("lon","lat", "elevation")] )
        }

				# you can nest folders too with another folder start/end statement here

      kml.folder.end( con )

    kml.end( con )



