#' @title setup.lattice.options
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
   setup.lattice.options = function () {
      require( lattice )
      
      lattice.options( default.lattice.options )
      trellis.par.set(col.whitebg())

  #    bkg = trellis.par.get("background)
  #    bkg$col="white"
  #    trellis.par.set("background", bkg)

      s.bkg = trellis.par.get("strip.background")
      s.bkg$col="white"
      trellis.par.set("strip.background", s.bkg)

    }


