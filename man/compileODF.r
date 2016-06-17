#' @title compileODF
<<<<<<< HEAD
#' @description No description. Requires the \code{parse.odf.file()} function from this package.  
=======
#' @description Compile ODF files from in a specific folder (path) CTD casts into a data frame.  This script only requires casts to be labeled either down ('D') or up ('U') along the file naming convention
>>>>>>> bf95e902aee0ad93fe38708ebce4b3dc92acc347
#' @param \code{path} = location of an ODF file
#' @return \code{result}
#' @note MMM - 2016-06-17 - Unable to get this to work.
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
