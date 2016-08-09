#' @title make.hist
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
    make.hist = function (data, v, basedir, res=300, type="histogram", sizevar="cw", weightvar="sa.weight", bandwidth = 0.2, xrange, yrange, nsets) {

      outdir = file.path(type, basedir)
      dir.create(outdir, recursive=T)

      yr = unique(data$yr)

        if (dim(data)[1]>1) {
        for (vs in v) {
          z = data[filter.class(data, vs), c(sizevar, weightvar)]
          size = expand.weights (x=z[,sizevar], w=z[,weightvar])
          o = length(size)
          n = o / nsets
          rm (z)
          if (o > 1) {
            rootname = paste(vs, yr, sep="")
            outfile.png = file.path(outdir, paste(rootname, ".png", sep=""))
            outfile.pdf = file.path(outdir, paste(rootname, ".pdf", sep=""))

            print(paste(outfile, n))

             if (type=="density") {
                plot(density(size, bw=bandwidth, kernel="gaussian"), xlim=xrange, main=paste(vs, yr), lwd=4, cex=5)
              }
              if (type=="histogram") {
                breaks = seq(0, 190, bandwidth)
                hi = hist(size, breaks=breaks)
                hi$counts = hi$counts / nsets
                plot(hi, xlim=xrange, ylim=yrange, main=rootname, lwd=4, cex=5, col="blue3")
              }
            Pr(dev="pdf", fname=outfile.pdf, width=6, height=3)
            convert.graphics.format (outfile.pdf, outfile.png )
          #      mtext(signif(n,3), line=-4, side=3, font=1, col="blue", cex=1.5, adj=1)
            rm (size)
            gc()
          }
      }}
    }


