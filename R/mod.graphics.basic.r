#' @title mod.graphics.basic
#' @description unknown
#' @family abysmally documented
#' @author unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  mod.graphics.basic = function(files, outformat="") {

       if (outformat == "ps2eps") {
        for (fi in files ) {
          fo = gsub("ps$", "eps", fi, "&")
          cmd( "ps2epsi", fi, fo )
          print( paste( "Converting to", fo) )
        }
      }

      if (outformat == "ps2pdf") {
        for (fi in files ) {
          fo = gsub("ps$", "pdf", fi)
          cmd( "epstopdf", fi, ">", fo, "&" )
          print( paste( "Converting to", fo) )
        }
      }

      if (outformat == "eps2pdf") {
        for (fi in files ) {
          fo = gsub("eps$", "pdf", fi)
          cmd( "epstopdf", fi, ">", fo, "&" )
          print(paste( "Converting to", fo) )
        }
      }


      if (outformat == "ps2png") {
        for (fi in files ) {
          fo = gsub("ps$", "png", fi)
          gscmd = paste("gs -q -dSAFER -dNOPAUSE -sDEVICE=png16m -r300x300 -sOutputFile=", fo, sep="" )
          cmd( gscmd, fi, "< /dev/null ")
          convert.graphics.format (fo, fo, options="-trim -antialias -quality 9 " )
          print(paste( "Converting to", fo) )
        }
      }

      # gscmd = paste("gs -q -dSAFER -dNOPAUSE -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -dMaxBitmap=10000000 -sDEVICE=png16m -r300x300 -sOutputFile=", fo, sep="" )

      # -dMaxBitmap=500000000

      if (outformat == "ps2jpg") {
        for (fi in files ) {
          fo = gsub("ps$", "jpg", fi)
          gscmd = paste("gs -q -dSAFER -dNOPAUSE -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -dDOINTERPOLATE -sDEVICE=jpeg -dJPEGQ=100 -r300x300 -sOutputFile=", fo, sep="" )
          cmd( gscmd, fi, "< /dev/null ")
          convert.graphics.format (fo, fo, options="-trim -antialias -quality 9" )
          print(paste( "Converting to", fo) )
        }
      }

      if (outformat == "png2swf") {
        f1 = gsub("png$", "jpg", files[1])
        cmd( "png2swf -X 1024 -r 1 -o", f1, files, "&" )
        print(paste( "Converting to", f1) )
      }

      if (outformat == "png2mpg") {
        f1 = gsub("png$", "mpg", files[1])
        cmd( "images2mpg -T /tmp -t 5 -d 2 -v 0", "-o", f1, "-i", files, "&" )
        print(paste( "Converting to", f1) )
      }

      if (outformat == "png2gif") {
        f1 = gsub("png$", "gif", files[1])
        convert.graphics.format (files, f1, options="-delay 250 -antialias -quality 9" )
        print(paste( "Converting to", f1) )
      }

   }


