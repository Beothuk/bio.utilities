#read table to copied from excel
rX <- function(header=T) {
	read.table('clipboard-512',sep="\t",header=header)
}