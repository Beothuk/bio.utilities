#' @title compileODF
#' @description No description
#' @param \code{path} = location of an ODF file
#' @return \code{result} =  what the function returns
#' @note requires the \code{parse.odf.file()} function from this package.  Currently don't have an *.odf file to test this on
#' @family poorly documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
compileODF <- function(path=loc) {
		f 	<- file.path(path)
		fi 	<- dir(f,full.names=T)
		fi 	<- fi[grep('.ODF',fi)]
		fi 	<- fi[grep("D",fi)]
		
		for(i in 1:length(fi)) {
			o <- parse.odf.file(fi[i])
		if(i==1) {
		out <- o
		}else {
			out <- rbind(out,o)		
			}				
		}
		return(out)
	}