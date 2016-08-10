#' @title xkill
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
xkill = xk = function( d=NULL ) {
  if (is.null(device)) {
    while ((which <- dev.cur()) != 1) dev.off(which)
  } else if (device==0 ) {
    dev.off( dev.cur )
  } else {
    try( dev.off( device ) )
    dev.list() 
  }
}

