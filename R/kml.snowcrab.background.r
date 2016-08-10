#' @title kml.snowcrab.background
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  kml.snowcrab.background = function( filename) {
    
    con = kml.start( filename, "Snow crab background layers" )
    
    # define point styles/colours, etc
    kml.polygon.make( con, item="style", style.id="polygon.gully", 
      colour="4c00ffff", line.colour="ff33f8ff", line.width=1, fill=1, outline=0 )
    kml.polygon.make( con, item="style", style.id="polygon.shrimp", 
      colour="4c7fffff", line.colour="ff7fffff", line.width=1, fill=1, outline=0 )

    kml.line.make( con, item="style", style.id="line.soft", line.colour="ff7fffff", line.width=1 )
    kml.line.make( con, item="style", style.id="line.cfa", line.colour="bfffffff", line.width=3 )


    kml.folder.start( con, folder.name="Scotian Shelf snow crab", 
      desc="Asssessment tools for the Scotian Shelf snow crab (Bedford Institute of Oceanography)" 
    )
    
        
      kml.background.make( con, name="Bathymetry", colour="e6ffffff", 
        href="http://nssnowcrab.googlepages.com/ss.bathy.colour.tif", x = c(50, 40, -52, -72) ) # n,s,e,w
        
      # kml.background.make( con, name="Bathymetry contour", colour="e6ffffff", 
      #   href="http://nssnowcrab.googlepages.com/ss.bathy.contour.tif", x = c(50, 40, -52, -72) ) # n,s,e,w

     # Management lines
      kml.folder.start( con, folder.name="Management lines" )

        kml.polygon.make( con, name="Gully MPA", style.id="polygon.gully", x=coordinates.db("gully") )
        kml.line.make( con, name="CFA23-CFA24", style.id="line.cfa", x=coordinates.db("cfa23-cfa24") )
        kml.line.make( con, name="SENS-CFA4X", style.id="line.cfa", x=coordinates.db("sens-cfa4x") )
        kml.line.make( con, name="CFA23 inshore-offshore", style.id="line.cfa", x=coordinates.db("cfa23.inshore-offshore") )
        kml.line.make( con, name="NENS-SENS", style.id="line.cfa", x=coordinates.db("nens-sens") )
        kml.line.make( con, name="Gulf-NENS", style.id="line.cfa", x=coordinates.db("gulf-ss") )
        kml.line.make( con, name="23-24", style.id="line.cfa", x=coordinates.db("gully") )

        kml.folder.start( con, folder.name="NENS soft-shell closure lines" )
          kml.line.make( con, name="6-7", style.id="line.soft", x=coordinates.db("nens.ss.6-7") )
          kml.line.make( con, name="5-6", style.id="line.soft", x=coordinates.db("nens.ss.5-6") )
          kml.line.make( con, name="4-5", style.id="line.soft", x=coordinates.db("nens.ss.4-5") )
          kml.line.make( con, name="3-4", style.id="line.soft", x=coordinates.db("nens.ss.3-4") )
          kml.line.make( con, name="2-3", style.id="line.soft", x=coordinates.db("nens.ss.2-3") )
          kml.line.make( con, name="1-2", style.id="line.soft", x=coordinates.db("nens.ss.1-2") )
          kml.line.make( con, name="outside1", style.id="line.soft", x=coordinates.db("nens.ss.outside.1") )
          kml.line.make( con, name="outside2", style.id="line.soft", x=coordinates.db("nens.ss.outside.2") )
        kml.folder.end (con)
    
        kml.folder.start( con, folder.name="Shrimp boxes" )
          kml.polygon.make( con, name="NW Sable", style.id="polygon.shrimp", x=coordinates.db("shrimp.nw.sable") )
          kml.polygon.make( con, name="Louisburg Hole", style.id="polygon.shrimp", x=coordinates.db("shrimp.louisburg") )
          kml.polygon.make( con, name="Eastern Holes", style.id="polygon.shrimp", x=coordinates.db("shrimp.eastern") )
          kml.polygon.make( con, name="Bad Neighbours", style.id="polygon.shrimp", x=coordinates.db("shrimp.bad.neighbours") )
        kml.folder.end (con)

      kml.folder.end (con)
   
    kml.folder.end( con )
    kml.end( con )


    print( "Google earth file has been completed and saved as the following: ")
    print( filename )
  }


