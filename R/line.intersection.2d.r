#' @title line.intersection.2d
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
line.intersection.2d = function( p1a, p1b, p2a, p2b ) {

  dim_num = 2
  
  line1 = explicit.to.implicit.2d.line( p1a, p1b )
  line2 = explicit.to.implicit.2d.line( p2a, p2b )

#%  Set up and solve a linear system.
  a = rbind( line1, line2)
  y = - a[,3] 
  X = a[,c(1:2)]
  p = try( solve ( X,y) ) 

#%  If the inverse exists, then the lines intersect at the solution point.

  if ( class( p ) == "try-error" ) p=NULL
  
#%  If the inverse does not exist, then the lines are parallel
#%  or coincident.  

  return ( p )

}


