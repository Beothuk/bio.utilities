#' @export
 
  offset.determine = function(x) {
    offset = median(x)
    y = x[ is.finite(x) & x>0 ]
    if( offset==0 && length(y) > 0) offset = min(y)
    return(offset)
  }


