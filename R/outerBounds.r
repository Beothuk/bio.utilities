
outerBounds = function(pointData, round.digit= 3){

#// for creating a tight polygon around a dense set of points

	require(PBSmapping)

	Ys=sort(unique(round(pointData$Y,round.digit)))
	Xs=sort(unique(round(pointData$X,round.digit)))
	X1=c()
	X2=c()
	Y1=c()
	Y2=c()

	for (x in 1:length(Xs)) {
		Y2[x]=max(pointData$Y[round(pointData$X,round.digit)==Xs[x]],na.rm=T)
		Y1[x]=min(pointData$Y[round(pointData$X,round.digit)==Xs[x]],na.rm=T)
	}

	tmp1=data.frame(X=c(Xs,rev(Xs)),Y=c(Y2,rev(Y1)))
	poly1=data.frame(PID=1,POS=1:nrow(tmp1),tmp1)

	for (y in 1:length(Ys)) {
		X2[y]=max(pointData$X[round(pointData$Y,round.digit)==Ys[y]],na.rm=T)
		X1[y]=min(pointData$X[round(pointData$Y,round.digit)==Ys[y]],na.rm=T)
	}

	tmp2=data.frame(X=c(X2,rev(X1)),Y=c(Ys,rev(Ys)))
	poly2=data.frame(PID=2,POS=1:nrow(tmp2),tmp2)

	poly=joinPolys(poly1,poly2,operation="INT")

	return(poly)

}