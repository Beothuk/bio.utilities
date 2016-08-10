#' @title idHoles
#' @description PBS mapping utility to identify holes in a PolySet
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
idHoles<-function(Polys){
	sids<-unique(Polys$SID)
	Polys$Hole<-NA
	for(i in sids){
		Polys$Hole[Polys$SID==i]<-ifelse(diff(subset(Polys,SID==i)$POS)[1]<0,T,F)
	}
	Polys
}
