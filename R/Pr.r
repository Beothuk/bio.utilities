#' @title Pr
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  Pr = function(dev=NULL, dname=NULL, fname=NULL, trim=T, width=10, height=10, res=100, pointsize=40, ...) {
    if (is.null(dev)) {
      dev.print(pdf, "temp.pdf")
      system("lpr -Php temp.pdf")
      remove.files( "temp.pdf")
    }
    else {
      dir.create(path=dname, recursive=T, showWarnings=F)

      root = paste(fname, ".", dev, sep="")
      pdffile = paste(fname, ".", "pdf", sep="")

      if (dname=="") dname=NULL
      outfile = ifelse(is.null(dname), root, file.path(dname, root ))
      pdffile = ifelse(is.null(dname), pdffile, file.path(dname, pdffile ))
      
      if (dev=="png") {
        dev.print(pdf, pdffile, ...)
        if (trim) cmd ( "convert -antialias  -trim  -quality 9 +dither -geometry 200%  -frame 1% -mattecolor white ", pdffile, outfile  )
        if (!trim) cmd ( "convert -antialias  -quality 9 -geometry 200%  -frame 1% -mattecolor white", pdffile, outfile  )
      }

      if (dev=="jpg") {
        jpeg( file=outfile, ... )
        dev.set( dev.prev() )
        dev.copy(jpeg)
        dev.off()
        dev.off()
      }

      if (dev=="pdf") dev.print(pdf, outfile, ...)

      if (dev=="eps") dev.copy2eps(file=outfile, ...)
    }
  }


