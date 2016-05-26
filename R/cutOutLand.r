cutOutLand<-function(Polys,coast,mapRes="UR",keepUniquePolys=T){
#// PBS mapping utility to remove the land from management area polygons, include coastline data or defaults to "ecomod_data/lobster/data/maps/gshhs/shorelineUR.csv"
	if(missing(coast))coast<-read.csv(file.path( project.datadirectory("lobster"), "data","maps","gshhs",paste0("shoreline",mapRes,".csv")))
	attr(coast,"projection")<-"LL"
	coast<-clipPolys(coast,xlim=range(Polys$X),ylim=range(Polys$Y))
	
 if(!is.null(coast)){
        coast<-idHoles(coast)

		if(keepUniquePolys) {
				lp = NULL
				np = names(Polys)
				if(exists('SID',Polys)) Polys$PID = with(Polys,as.numeric(paste(PID,SID,sep='.')))
				up = unique(Polys$PID)
	
			for(u in up) {

			kp = joinPolys(Polys[which(Polys$PID==u),],subset(coast,Hole==F),"DIFF")
			if(exists('SID',Polys)) {
					io = as.numeric(strsplit(as.character(u),"\\.")[[1]])
					ap = unique(kp$SID)
					kp$PID = io[1]
				
					for(a in ap) {
						v = which(kp$SID==a)
						if(a == 1) {
							kp$SID[v] = io[2] 
						} else {
							kp$SID[v] = io[2] * (kp$SID[v]*1000)
						}		
					}
				}
			lp = rbind(lp,kp)
		}
		return(lp)
		} else {
		coast<-idHoles(coast)
		Polys.out<-joinPolys(Polys,subset(coast,Hole==F),"DIFF")
		}
	} else {
		Polys.out<-Polys
	}
}						
