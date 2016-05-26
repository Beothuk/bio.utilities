#write table to paste into excel
cX <- function(X,row.names=F) {
	write.table(X,'clipboard-512',sep="\t",row.names=row.names)
}