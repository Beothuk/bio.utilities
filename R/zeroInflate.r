#' @title zeroInflate or blanking
#' @description incorporates blanking distance by including zeros spaced eqully at the average nearest nieghbour distance, default blanking distance is the nearest neighbour distance of the most isolated point. Called by interpolation.
#' @param xyz = data.frame of points containing X and Y coordinates
#' @param blank.dist = distance at which zeros are inserted into the data set, defaults to the largest nearest neighbour distance i.e. the distance to the most isolated point in the data
#' @param aspr = aspect ratio for for creating square grid
#' @param type = how spaced out the zeros are, 1 = avg. nearest neighbour distance, 2 = blanking distance
#' @param eff = what data is inserted, intended for zeros
#' @param scale = how far beyond the range of the data are points inserted
#' @author Brad Hubley 
#' @export

zeroInflate = function(xyz,blank.dist,scale=20,corners=NULL, aspr=1, type=2, eff=0,type.scaler=1){
	

	require(spatstat)
#    browser()
    pbd=F
    xyz.names = names(xyz)
    names(xyz) = c('X','Y','Z')
    pts = subset(xyz,select=c('X','Y'))
    if(!is.null(corners)){
        xmin = corners$plon[1]
        xmax = corners$plon[2]
        ymin = corners$plat[1]
        ymax = corners$plat[2]
        W = owin(corners$plon,corners$plat)
    }
    else{
        xmin = min(pts$X)
        xmax = max(pts$X)
        ymin = min(pts$Y)
        ymax = max(pts$Y)
        W = owin(c(xmin-scale,xmax+scale),c(ymin-scale,ymax+scale))
    }
    pts.ppp = as.ppp(pts,W)
    if(missing(blank.dist)){
        pbd=T
        blank.dist = max(nndist(pts.ppp))
    }
    if(type==1)dims = c(round((ymax-ymin)/(mean(nndist(pts.ppp))*type.scaler)*aspr),round((xmax-xmin)/(mean(nndist(pts.ppp))*type.scaler)))
    if(type==2)dims = c(round((ymax-ymin)/(blank.dist*type.scaler)*aspr),round((xmax-xmin)/(blank.dist*type.scaler)))
    blank.map = distmap(pts.ppp,dim=dims)
    blank.dat = data.frame(X=sort(rep(blank.map$xcol,blank.map$dim[1])),Y=rep(blank.map$yrow,blank.map$dim[2]),dist=as.vector(blank.map$v))
    blank.dat = subset(blank.dat,dist>blank.dist,c('X','Y'))
    xyz = merge(xyz,data.frame(blank.dat,Z=eff),all=T)
    if(pbd)print(paste("blanking distance",blank.dist))

    names(xyz) = xyz.names
    return(xyz)
    
}    
