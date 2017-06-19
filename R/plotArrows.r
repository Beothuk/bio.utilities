#' @export
plotArrows = function (Y,X,add=F,colfun=rainbow,startend=T,...) {

  #//trace arrows around x,y points from start to end
  xl = c(min(X),max(X))
  yl = c(min(Y),max(Y))
  if(Y[length(Y)]==0) {Y=Y[-length(Y)]}
  if(length(Y) !=length(X)) {X=X[-length(X)]}
  n = length(Y)
  cl = colfun(n)
  if(add==F) plot(1,1,ylim=yl,xlim=xl,type='n')
  
  for(i in 1:n) {
    arrows(x0=X[i],x1=X[i+1],y0=Y[i],y1=Y[i+1],angle=45,col=cl[i],...)
  }
  points(X,Y,pch=16,cex=1,col='black')
  if(startend){
    points(X[1],Y[1],pch=17,cex=2,col='black')
    points(X[n],Y[n],pch=17,cex=2,col='black')
  }
}
