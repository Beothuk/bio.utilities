#' @title list.names.to.columns
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
list.names.to.columns<-function(data) {
	for(i in 1:length(data)) {
			if( !is.null(data[[i]])) {
				data[[i]][length(data[[i]])+1]<-names(data[i])
				if(grepl('\\.',length(data[[i]])+1)) {a<-unlist(strsplit(data[[i]][length(data[[i]])],split="\\."))
				  data[[i]]<-as.vector(c(data[[i]],(a)))
			  }
						}
					}
			data<-do.call(rbind,data)
			return(data)
		}