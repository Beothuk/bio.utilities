#Parallel computing is a method of spreading analyses or groups of analyses across the processors in your computer to decrease computation time.  
#Not all analyses can be easily run in parallel, but anything that is run with a a for loop or an apply function can be relatively easily converted to parallel. 
#uses package snow or parallel

RLibrary(c('parallel','snowfall','snow'))
#set up your parameter list and figure out how many processors	

#Make some
set.seed(987654321) #make reproducible example
	n <- 200
	x <- rnorm( n, sd=2)
	eps <- rnorm( n, sd=x^2 ) #add in non constant variance 
	y <- 1 + 2*x + eps #true relationship between y and x

plot( x, y )

fit <- lm( y ~ x )
summary( fit ) #least squares relationships between y and x assuming normally distributed residuals


#but what about bootstrapped least squares relationship as we know there is non constant variance, because we made it so.
bsPairs <- function(ip=1:100,n=200,xx,yy){
	ou <- list()
	for(i in ip){
		s <- sample( 1:n, replace=TRUE )
		fit <- lm( yy ~ xx, subset=s )
		ou[[i]]<- fit$coef
		}
		return(do.call('rbind',ou))
	}
nreps = 21000
system.time(out <- bsPairs(yy=y,xx=x,ip=1:nreps))


clusters = rep("localhost", detectCores() )
sfInit(parallel=T,cpus=length(clusters),type='SOCK',socketHosts=clusters)

system.time(  out <- sfClusterCall(fun=bsPairs,ip=1:round(nreps/length(clusters)),xx=x,yy=y,n=200))
sfStop()
res <- do.call('rbind', out )
dim( res )

apply( res, 2, sd ) ##bootstrapped SE

summary(fit)$coef