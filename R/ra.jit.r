#' @title ra.jit
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  ra.jit = function(jvalue=1) {
  # kind of slow  ... try the jit approach
    if ( library(jit, logical.return = T))  {
      require(jit)
      if (is.ra) {
        jit( jvalue ) # 1= normal, 2=inner loop optimisations
      }
    }
  }

