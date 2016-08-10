#' @title mergePolys
#' @description PBS mapping utility to merge complex polygon with multiple SIDs into one large polygon (outer boundary)
#' @family abysmally documented
#' @author unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
mergePolys<-function(Polys){
	sids<-unique(Polys$SID)
	Polys.out<-subset(Polys,SID==sids[1])
	for(i in 2:length(sids)){
		Polys.out<-joinPolys(Polys.out,subset(Polys,SID==sids[i]),"UNION")
	}
	Polys.out
}

