#' @title matrixBubbles
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export

matrixBubbles <- function (dmat,xr,yr,ttl,xlab,ylab,maxinch,colors,zeroflag=T,yc.colors=F,ch.col = c("rainbow(nx,alpha=0.5)", "heat.colors(nx,alpha=0.5)","terrain.colors(nx,alpha=0.5)",
 "topo.colors(nx,alpha=0.5)","cm.colors(nx,alpha=0.5)"),xlabs = seq(1970,2015,by=5)){                                                      
	nx = length(xr)                                                                                                               
	ny= length(yr)                                                       
	npts = nx * ny                                                                                                                
	dmat <- as.matrix(dmat)
	io = which(dmat>quantile(dmat,0.99)) #prune the largest samples to a smaller size i.e. max bubbles are the lowest 99%
	
	dmat[io] <- quantile(dmat,0.99)
	if(length(dmat) != npts) return("length error")                                                                               
	mat3 = matrix(0,nrow = npts,ncol = 4)                                                                                         
	sca = maxinch/max(abs(dmat))
	if(yc.colors) {
		v<-eval(parse(text=ch.col))
		mat<-matrix(v,nrow=ny,ncol=nx,T)
		for( i in 2:ny){
		mat[i,]<-c(mat[i-1,nx],mat[i-1,-nx])
		}
	col.vec=as.vector((mat))
	k = 0                                                                                                                         
	for(i in 1:nx){                                                                                                               
		for(j in 1:ny){                                                                                                              
			k = k + 1                                                                                                                   
			mat3[k,] = c(xr[i],yr[j],dmat[j,i]/sca,col.vec[k])                                                                                     
		}
	    plot(1,1,type='n',xlim=c(0.5,nx+0.5),ylim=c(0.5,ny+0.5),xlab = xlab,ylab = ylab,xaxt='n')                                                                                                        
		    imask = mat3[,3] > 0                                                                                                          
	symbols(mat3[imask,1],mat3[imask,2], circles = mat3[imask,3],xlab = xlab,ylab = ylab,add=T,main = ttl,inches = maxinch,bg=mat3[imask,4])
	negmask = !imask                                                                                                              
	negz= abs(as.numeric(mat3[negmask,3]))                                                                                                    
	symbols(mat3[negmask,1],mat3[negmask,2], circles = negz,add = TRUE,inches = maxinch,bg=mat3[negmask,4])                             
	if(zeroflag) {                                                                                                                
		zmask = mat3[,3] == 0                                                                                                        
		points(mat3[zmask,1],mat3[zmask,2], pch = 3,col=2,cex = 0.5,lwd = 1)                                                         
		}
		}	
		mu = (xlabs[2]-xlabs[1])
	axis(side=1,labels=xlabs,at=seq(1,(length(xlabs)*mu),by=mu))
		} 
		if(yc.colors==FALSE) {
	colors <- rgb(t(col2rgb(colors)),maxColorValue=255,alpha=125)                                                                                
    imask = mat3[,3] > 0  
    plot(1,1,type='n',xlim=c(1,(nx)),ylim=c(1,ny))                                                                                                        
	symbols(mat3[imask,1],mat3[imask,2], circles = mat3[imask,3],xlab = xlab,ylab = ylab,main = ttl,inches = maxinch,bg=colors[1])
	negmask = !imask                                                                                                              
	negz= abs(mat3[negmask,3])                                                                                                    
	symbols(mat3[negmask,1],mat3[negmask,2], circles = negz,add = TRUE,inches = maxinch,bg=colors[2])                             
	if(zeroflag) {                                                                                                                
		zmask = mat3[,3] == 0                                                                                                        
		points(mat3[zmask,1],mat3[zmask,2], pch = 3,col=2,cex = 0.5,lwd = 1)                                                         
		}
		}                                                                                                                            
}                                                                                                                              
                                                                                                                               
                                                                                                                               
#xx = matrix(sample(100,48),nrow = 8)                                                                                           
#xy =  xx - 50                                                                                                                  
#xy[5:7,1:3] = 0                                                                                                                
#myBubbles(dmat=xy,xr = 1:6,yr=1:8,ttl="ttl",xlab="XX",ylab="YY",maxinch = .4,yc.colors=F,colors = c("green","blue"),zeroflag = TRUE,ch.col="rainbow(nx)")            
