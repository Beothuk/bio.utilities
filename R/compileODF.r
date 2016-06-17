#' @title compileODF
#' @description Compile ODF files from in a specific folder (path) CTD casts into a data frame.  This script only requires casts to be labeled either down ('D') or up ('U') along the file naming convention
#' @param \code{path} = location of an ODF file
#' @return \code{result} =  what the function returns
#' @note requires the \code{parse.odf.file()} function from this package.  Currently don't have an *.odf file to test this on
#' @family poorly documented
#' @author  Adam Cook, \email{Adam.Cook@@dfo-mpo.gc.ca}
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
