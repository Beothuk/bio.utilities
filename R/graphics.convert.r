#' @title graphics.convert
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
graphics.convert = function( infile=NULL, outfile.basename=NULL, formats=NULL) {

  for ( outformat in formats ) {
    if (outformat == "ps2eps") {
      outfile = paste(outfile.basename, "eps", sep=".")
      print( paste( "Converting to", outfile) )
      cmd( "ps2epsi", infile, outfile, "&" )
    }
    if (outformat == "ps2pdf") {
      outfile = paste(outfile.basename, "pdf", sep=".")
      print( paste( "Converting to", outfile) )
      cmd( "epstopdf", infile, ">", outfile, "&" )
    }
    if (outformat == "eps2pdf") {
      outfile = paste(outfile.basename, "pdf", sep=".")
      print(paste( "Converting to", outfile) )
      cmd( "epstopdf", infile, ">", outfile, "&" )
    }
    if (outformat == "ps2png") {
      outfile = paste(outfile.basename, "png", sep=".")
      print(paste( "Converting to", outfile) )
      gscmd = paste("gs -q -dSAFER -dNOPAUSE -sDEVICE=png16m -r300x300 -sOutputFile=", outfile, sep="" )
      cmd( gscmd, infile, "< /dev/null ")
      convert.graphics.format (outfile, outfile, options="-trim -antialias -quality 9 " )
    }
    if (outformat == "ps2jpg") {
      outfile = paste(outfile.basename, "jpg", sep=".") 
      print(paste( "Converting to", outfile) )
      gscmd = paste("gs -q -dSAFER -dNOPAUSE -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -dDOINTERPOLATE -sDEVICE=jpeg -dJPEGQ=100 -r300x300 -sOutputFile=", outfile, sep="" )
      cmd( gscmd, infile, "< /dev/null ")
      convert.graphics.format (outfile, outfile, options="-trim -antialias -quality 9 " )
    }
  }
}


