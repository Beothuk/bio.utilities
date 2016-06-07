#source('C:/Documents and Settings/cooka/Desktop/Scripts/Surplus Production dec 2011/bugs/finding moments of distributions.R')



####Written by: 	AM Cook
####Purpose: 		to find the first two moments of a distrbution from quantile breaks (defined by the upper and lower percent)
####Date:			February 10, 2012 
####Note: 			Gamma distribution returns shape and scale rather than rate (as per winbugs distribution) for use in r rate=1/scale
### lo and l.perc are the value and percentile for the low end of the distribution, up and u.perc are the upper values and percentiles


findMoments <- function(lo=0.1,up=0.8,l.perc=0.025,u.perc=0.975,dist=c('norm','lnorm','weibull','gamma','inv.gamma'),plot=T) {
	if(dist=='norm') {
			 sig2 = ((up-lo)/(qnorm(u.perc)-qnorm(l.perc)))^2
			 xbar = (lo*qnorm(u.perc)-up*qnorm(l.perc))/(qnorm(u.perc)-qnorm(l.perc))
			 if(plot) {
			 plot(density(rnorm(10000,xbar,sqrt(sig2))),main='')
			 abline(v=lo)
			 abline(v=up)
			 }
			 return(list(xbar=xbar,sig2=sig2))
	  }
	if(dist=='lnorm') {
			 sig2 = ((log(up)-log(lo))/(qnorm(u.perc)-qnorm(l.perc)))^2
			 xbar = (log(lo)*qnorm(u.perc)-log(up)*qnorm(l.perc))/(qnorm(u.perc)-qnorm(l.perc))
			 if(plot) {
			 plot(density(rlnorm(10000,xbar,sqrt(sig2))),main='')
			 abline(v=lo)
			 abline(v=up)
			 }
			  return(list(xbar=xbar,sig2=sig2))
	 }
	if(dist=='weibull') {
			gam = (log(-log(1-u.perc))-log(-log(1-l.perc)))/(log(up)-log(lo))
			beta = lo/(-log(1-l.perc))^(1/gam)
			if(plot) {
		 	plot(density(rweibull(10000,gam,beta)),main='')
		 	abline(v=lo)
		 	abline(v=up)
		 }
			return(list(shape=gam,beta=beta))
	}
	if(dist=='gamma') {
			a=mean(c(lo,up))
			alpha <- function(a) {
			b <- qgamma(u.perc,a,1) / qgamma(l.perc,a,1) 
			o = (b-(up/lo))^2
			return(list(a=a,o=o))
			}
			op<-function(a) alpha(a)$o
			ot <- optimize(f=op,interval=c(0,up))
			alp <- ot$minimum
			en <- lo/qgamma(l.perc,alp,1)
			if(plot) {
		 	plot(density(rgamma(10000,alp,scale=en)),main='')
		 	abline(v=lo)
		 	abline(v=up)
		 }
			return(list(shape=alp,scale=en))
	}
		if(dist=='inv.gamma') {
			a=mean(c(1/lo,1/up))
			ilo<-1/lo
			iup<-1/up
			alpha <- function(a) {
			b <- qgamma((1-u.perc),a,1) / qgamma((1-l.perc),a,1) 
			o = (b-(iup/ilo))^2
			return(list(a=a,o=o))
			}
			op<-function(a) alpha(a)$o
			ot <- optimize(f=op,interval=c(0,up))
			alp <- ot$minimum
			en <- ilo/(1/qgamma((1-l.perc),alp,1))
			if(plot) {
		 	plot(density(1/rgamma(10000,alp,scale=1/en)),main='') 
		 	abline(v=lo)
		 	abline(v=up)
		 }
			return(list(shape=alp,scale=en))
	}
}
