#' @export
#' @title convert.graphics.format
#' @description this uses imagemagicks functionality
#' @note does not work in Windows
#' @param \code{file0} 
#' @param \code{file1} 
#' @param \code{options} 
#' @return \code{} 
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @references \url{http://www.imagemagick.org/script/convert.php}
#' @export
  convert.graphics.format = function (file0, file1, options="" ) {
		#    cmd("convert", options, file0, file1, "&")
    cmd( "convert", options, file0, file1 )
  }


