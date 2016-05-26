gridData <- function(Data,domain.poly,lvls,bcol="YlGnBu",border=1,FUN=mean,grid.size=1,aspr="calculate",sx,sy,ex,ey) {  

#// summarizes data onto a grid, creates PBSmapping polySet and polyData 
	print("Mike's a dork")
	require(PBSmapping)
	require(RColorBrewer)
	names(Data)[1:4]<-c("EID","X","Y","Z")

	# Domain polygon to select data
	if(!missing(domain.poly))Data <- subset(Data,EID%in%findPolys(Data,domain.poly)$EID)

	if(missing(sx)) sx = floor(min(Data$X))
	if(missing(sy))	sy = floor(min(Data$Y))
	if(missing(ex)) ex = ceiling(max(Data$X))
	if(missing(ey))	ey = ceiling(max(Data$Y))

	# Aspect ratio
	if(aspr=="calculate"){
		require(CircStats)
		aspr=1/cos(rad(mean(c(sy,ey))))
	}

	# Make grid
	gx = grid.size/111.12 * aspr
	gy = grid.size/111.12
	grid   <- makeGrid(x=seq(sx,ex,gx),y=seq(sy,ey,gy),projection="LL")
	
	
	# locate EventData in grid and create polyData with summary stats
	locData<- findCells(Data, grid) 
	pdata  <- combineEvents(Data, locData, FUN=FUN)

	cols   <- brewer.pal(length(lvls),bcol) 
	pdata  <- makeProps(pdata, c(lvls,max(lvls)*100), "col", cols) 
	pdata$border<-border
	
	return(list(polys=grid, polyData=pdata, lvls=lvls, col=cols))
	
}
