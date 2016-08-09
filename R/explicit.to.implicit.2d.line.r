#' @title explicit.to.implicit.2d.line
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
 # ----------------
 explicit.to.implicit.2d.line = function ( p1, p2 ) {

# LINE_EXP2IMP_2D converts an explicit line to implicit form in 2D.
#%      A * X + B * Y + C = 0
  dx = p1[1] - p2[1]
  dy = p1[2] - p2[2]
  slope = dy/dx
  # slope =  (p1[2] - Y) / (p1[1] - X)
  # slope * (p1[1]-X) = (p1[2]-Y)
  # slope * p1[1] - slope * X - p1[2] + Y = 0
  # - slope * X + Y + slope*p1[1] - p1[2] = 0
  A = -slope
  B = 1
  C = slope * p1[1] - p1[2]
  out = as.matrix( cbind( A,B,C) )
  return( out )

}


