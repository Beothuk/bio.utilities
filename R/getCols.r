#' @title getCols
#' @description get color vector for plot
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
getCols <- function(n){
 N <- 6
 
 X <- seq(N^2)-0.5
 Y <- seq(N)-0.5
 Z <- matrix(0, nrow=length(X), ncol=length(Y))
 
 LEV <- seq(0,1,,N) 
 R <- rep(LEV, each=N^2)
 G <- rep(rep(LEV, each=N), N)
 B <- rep(LEV, N^2)
 
 plot.new(width=6, height=6)
 layout(matrix(1:2, nrow=2, ncol=1), widths=c(6), heights=c(1.5,4.5))
 op <- par(mar=c(1,3,2,1))
 
 image(X,Y,Z, col=NA, xlab="", ylab="", xaxt="n", yaxt="n")
 for(i in seq(Z)){
  xs <- c(((i-1) %% N^2), ((i-1) %% N^2), ((i-1) %% N^2) + 1, ((i-1) %% N^2) + 1)
  ys <- c(((i-1) %/% N^2), ((i-1) %/% N^2)+1, ((i-1) %/% N^2) + 1, ((i-1) %/% N^2))
  polygon(xs, ys, col=rgb(R[i], G[i], B[i]), border=NA)
 }
 mtext(paste("Click on", n, "colors [please]"), side=3, line=0.5)
 box()
 
 COLS <- NA*seq(n)
 for(i in seq(n)){
  coord <- locator(1)
  red <- coord$y / N
  green <- coord$x / N^2
  blue <- (coord$x %% N) / N
  #pos <- (round(coord$y-1) * N^2) + round(coord$x)
  COLS[i] <- rgb(red, green, blue)
 }
 
 par(mar=c(1,3,0,1))
 pal <- colorRampPalette(c("black", "white"))
 image(x=1:100, y=seq(n), z=matrix(rep(1:100,n), nrow=100, ncol=n), col=pal(100), xlab="", ylab="", xaxt="n", yaxt="n")
 box()
 for(i in seq(n)){
  lines(x=c(1,100), y=c(i,i), col=COLS[i], lwd=4)
 }
 axis(2, at=seq(n))
 
 par(op)
 
 COLS
}
#usage getCols(5)