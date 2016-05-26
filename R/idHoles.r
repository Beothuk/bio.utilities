idHoles<-function(Polys){
#// PBS mapping utility to identify holes in a PolySet
	sids<-unique(Polys$SID)
	Polys$Hole<-NA
	for(i in sids){
		Polys$Hole[Polys$SID==i]<-ifelse(diff(subset(Polys,SID==i)$POS)[1]<0,T,F)
	}
	Polys
}
