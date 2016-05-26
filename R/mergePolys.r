
mergePolys<-function(Polys){
#// PBS mapping utility to merge complex polygon with multiple SIDs into one large polygon (outer boundary)
	sids<-unique(Polys$SID)
	Polys.out<-subset(Polys,SID==sids[1])
	for(i in 2:length(sids)){
		Polys.out<-joinPolys(Polys.out,subset(Polys,SID==sids[i]),"UNION")
	}
	Polys.out
}

