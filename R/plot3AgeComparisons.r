#' @title plot3AgeComparisons
#' @description plot triplets of age readings on a hexagon to compare 3 age readers or to compare 3 aging methods
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
plot3AgeComparisons = function(triplets,color="grey60",offset=.20){

# triplets is a matrix with number of rows equal to number of fish aged, and 3 columns.
# Each column contains the age readings obtained from one reader (or one aging method).
# The object is to compare the columns to see how the readers may differ.

# color sets the darkness of the grid of reference points. What you see on the screen may differ from
# what your printer gives you.

# offset determines how close to the reference point the number of observations is printed. 

# makes use of the function regpolygon()

# This function will implement the graphing procedure described by Evans, 
# G.T. and J.M. Hoenig.  1998.  Viewing and Testing Symmetry in Contingency 
# Tables, with Application to Fish Ages.  Biometrics 54:620-629.

# Programmed by J. Hoenig, Virginia Institute of Marine Science, hoenig@vims.edu

# First, test if the matrix triplets is numeric.

 if(!is.numeric(triplets)) {return("matrix is not numeric")}

# determine if there are NAs and, if so, eliminate them and alert the user.

test = complete.cases(triplets)
warn = sum(!test)
if (warn > 0) cat("warning: there are ",warn," records with missing values")
triplets = triplets[test,]

# now, subtract the lowest value in each row of triplets from each entry in the row

rowmins = apply(triplets,1,min)
triplets = triplets - rowmins
maxdif = max(triplets)


# draw a regular hexagon

 hexagon = regpolygon(lenside=maxdif)
 xvalues = hexagon$x
 yvalues = hexagon$y

 par(fin=c(5,5.62))

 plot(xvalues,yvalues,ylab="",xlab="",type="l",xlim=c(-maxdif,maxdif),
    ylim=c(-maxdif,maxdif),xaxt="n",yaxt="n")

# now add radii
  for (i in 1:6) {
    lines(x=c(0,xvalues[i]),y=c(0,yvalues[i]))
  }

# now add a grid of plotting nodes
x = matrix(NA,nrow=2*maxdif+1,ncol=2*maxdif+1)
y = matrix(NA,nrow=2*maxdif+1,ncol=2*maxdif+1)

for (i in 1:(2*maxdif+1)){
  for (j in 1:(maxdif+1)) {
    x[i,j] = i-maxdif-1-(j-1)*cos(pi/3)
    y[i,j] = (j-1)*sin(pi/3)
  }
}

for (i in 1:maxdif){
  for (j in (i+1):(maxdif+1)) {
    x[i,j] = NA
    y[i,j] = NA
  }
}

for (i in 1:(2*maxdif+1)){
  for (j in 1:(maxdif+1)) {
    points(x[i,j],y[i,j],pch=20,col=color)
    points(x[i,j],-y[i,j],pch=20,col=color)
  }
}

# now count how many observations there are at each plotting point

numcells = (maxdif + 1)^3
count = rep(NA,numcells)
dim(count) = c((maxdif+1),(maxdif+1),(maxdif+1))
xcoord = rep(NA,numcells)
dim(xcoord) = c((maxdif+1),(maxdif+1),(maxdif+1))
ycoord = rep(NA,numcells)
dim(ycoord) = c((maxdif+1),(maxdif+1),(maxdif+1))

for (i in 1:dim(triplets)[1]) {
   if (is.na(count[(triplets[i,1]+1),(triplets[i,2]+1),(triplets[i,3]+1)])) {
       count[(triplets[i,1]+1),(triplets[i,2]+1),(triplets[i,3]+1)] = 0 }
   count[(triplets[i,1]+1),(triplets[i,2]+1),(triplets[i,3]+1)] = 
       count[(triplets[i,1]+1),(triplets[i,2]+1),(triplets[i,3]+1)] + 1
}
for (i in 1:(maxdif+1)) {
   for (j in 1:(maxdif+1)) {
     for (k in 1:(maxdif+1)) {
       # compute the x & y coordinates for the plotting location
       xcoord[i,j,k] = i - j*cos(pi/3) - k*cos(pi/3)
       ycoord[i,j,k] = j*sin(pi/3) - k*sin(pi/3)
     }
   }
}

# now plot the data

for (i in 1:(maxdif+1)){
   for (j in 1:(maxdif+1)){
      for (k in 1:(maxdif+1)){
        if(!is.na(count[i,j,k])) points((xcoord[i,j,k]+offset),ycoord[i,j,k],pch=as.character(count[i,j,k]))
      }
   }
}

text(4.06,.45,"A")
text(-2.3,3.8,"B")
text(-2.3,-3.8,"c")

 return(list(triplets=triplets,x=x,y=y,count=count,xcoord=xcoord,ycoord=ycoord))

}

##################################################################

# regpolygon: compute (x,y) pairs that define the locations of the vertices of a regular polygon
# CJG, Aug. 7, 1995    modified by JM Hoenig June 2007 to run in R

regpolygon <- function(n=6,lenside=1,startang=0){

  # n        : the number of sides
  # lenside  : the length of each vertex to the center of the regular polygon
  # startang : the angle (degrees) of the first point on the polygon 
  #            w.r.t. the x-axis

  startang <- startang*(pi/180)  # convert to radians
  
  vertices <- seq(startang, startang+(2*pi), length=(n+1) )
  x <- cos(vertices)
  y <- sin(vertices)

  x <- x*lenside
  y <- y*lenside

  return(list(x=x,y=y))

}
