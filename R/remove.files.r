#' @title remove.files
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  remove.files = function (clean) {
    if (is.null(clean) || length(clean)==0 ) return()
    cf = file.info(clean)
    cfi = which( !is.na(cf$isdir) & !cf$isdir) 
    file.remove (clean[cfi]) 
    return ("done")
  }


