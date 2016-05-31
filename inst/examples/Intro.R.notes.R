#Easy start ups
#help function ?help
#source("") reads in functions that you have created elsewhere
#download package to r library utils:::menuInstallPkgs() or gui tool bar Packages<<Install Packages<< 
#require() or library() do the same thing-- they read in a package you have downloaded into your library
#R convention Y <- A states put object A into object Y

#---
#useful functions

	ls() #what objects are in your directory
	rm(A) #remove object A from your workspace rm(list=ls())--removes all objects from workspace
	
	getwd() #what is your working directory ie read and save files to
	setwd("C:/") #change your working directory note the forward slash
	
	dir() # lists all files in your working directory
	str(a) # gives you the data structure of your object a
	names(a) #gives names of object a you column names if data frame or if other object tells you what you can select



#---
#data objects in R 

	#note c() concatenates information into one vector c(1,2,3) makes a vector

	#vector--1 dim array of data can be allocated as:
		A <- c(1,2,3,4,5,6) #which coiencidentally does the same thing as A <- 1:6 or A <- seq(1,6,by=1) 
	
	#matrix--2dim array of data which you can allocate data to as:
		A <- matrix(c(1,2,3,4,5,6,7,8,9),nrow=3,ncol=3,byrow=T) #this makes a 3x3matrix with the vector of information put into the matrix by rows	
	
	#data.frame-- similar to matrix but has different properties for indexing in r
		A <- data.frame(A=c(1,2,3),B=c(4,5,6),D=c(7,8,9))
	
	#array-- an n-dimensional object
		A<-array(seq(1,27),dim=c(3,3,3)) #makes a three dimensional array of data with numbers 1-27

	#list-- the most flexible way to put data into an object in r, however it can get difficult to index good if you don't know how many rows of data there are going to be in your output or for storing data created through loops
		A <- list(A=letters,b=1:3,K=matrix(1:9,nrow=3,ncol=3))
		
#----		
#reading and writing data into R

	#from a data table saved as a csv
		A <- read.csv("C:/table.csv",header=T)
		write.csv(A,"C:/table.csv",rownames=F)
		
	#if you have a list of information you want to save and retrieve
		A <- load("C:/mylist.rdata")
		save(A,"C:/mylist.rdata")
	
	#pulling data from oracle or msaccess database need to set up an odbc link as start<<programs<<administrative tools<<data sources(odbc) << add <<oracle odbc driver
	# then go under TNS sevice name choose where your database is located probably either bank or sabs and give your data source name like BANK or QUODDY and add in your userid
	#need to get a package from R repository called RODBC once you have done this 
	
		require(RODBC)
		channel <- odbcConnect("server",uid="userid", pwd="password") #opens up a database channel connection for running your sql code
	
	#get the data by using the channel, and pasting in your sql query 
		A <- sqlQuery(channel,paste("select distinct mission,setno,spec,flen,clen from groundfish.gsdet where substr(Mission,4,4)=2012 and setno between 3 and 30 order by setno,spec,flen;"))
		
		#which you can then manipulate and rewrite back into a new data table
		
		sqlSave(channel,A,tablename='DATA_CHANGES',rownames=F)
		
	#you can read data in quickly using the clipboard so if it is in excel
		A <- read.table("clipboard",sep="\t",header=T) # the sep="\t" just says the data are tab delimited 
		write.table(A,"clipboard",sep="\t") 	

#selecting elements from your data

	#a vector
	A <- 1:10
	A[1] #give the object name and the element location
	
	#a matrix or data frame
	A <- data.frame(A=c(1,2,3),B=c(4,5,6),D=c(7,8,9))
	A[1,4] #object name[row,colum]
	A[1,] #all elements in the first row or A[,1] all the elements in the first column
	A$A #all elements of column A
	
	#a List
		A <- list(A=letters,b=1:3,K=matrix(1:9,nrow=3,ncol=3))
		A[[1]] #first object in list
		A[[1]][1] #first element of first object in list
		A$b[1] #indexed by name and element

#----		
#Plotting

#create some data

	A <- 1:100
	B <- A+rnorm(100,mean=100,sd=20)
	plot(A,B)
	plot(A,B,type='l')
	plot(A,B,type='b',pch=16)
	plot(A,B,type='b',pch=16,lty=3)
	plot(A,B,type='b',pch=16,lty=3,lwd=3)
	plot(A,B,type='b',pch=16,lty=3,lwd=3,col='red')
	plot(A,B,type='b',pch=16,lty=3,lwd=3,col='red',cex=1.5,xlab='Data1',ylab='Data2',main='Plots')

#multiple plots on the same page or changing the margins of your plots
#mfrow sets up the matrix of where the plots go
	par(mfrow=c(2,2))
	plot(A,B)
	plot(A,B,type='l')
	plot(A,B,type='b',pch=16)
	plot(A,B,type='b',pch=16,lty=3)

#mar sets up the margins
	par(mfrow=c(2,2),mar=c(3,3,3,1))
	plot(A,B)
	plot(A,B,type='l')
	plot(A,B,type='b',pch=16)
	plot(A,B,type='b',pch=16,lty=3)
	
#----
#correlation
	cor.test(A,B)
#to look up options for cor.test
	?cor.test	

#----
#linear regression

	P <- lm(B~A)
	#what do you get from this linear regression
	summary(P) # a summary of analysis
	plot(P) #gives you a series of diagnostic plots from the lm
	names(P) #gives you the object contained in the lm list we called P like the residuals coefficients etc
	
#plot the data and add the regression line	
	plot(A,B)
	abline(coef(P)) #abline is good for plotting regression outputs and other lines can do the same thing with lines(x=A,y=P$fitted)
	
	#add in the regression equation onto the plot
	text(x=15,y=200,paste('B~',round(coef(P)[1],2),'+',round(coef(P)[2],2),"A",sep="")) #couple of new things here I am pasting in the coefficients from object P into the equation and rounding them off as they are out to 10 digits in raw form, the text within the quotes are pasted directly and between the commas without the quotes are taken from my R object and pasted into the text
	
#for generalized linear models the function is glm, nls is for nonlinear least squares and if you wnat to do a user defined optimer problem where you set up your own likelihood optim is the function you want to use

#----
#lets write some simple functions

		adams.mean <- function(x) {
			y <- sum(x)/length(x)
			return(y)
		}
		
		adams.mean(c(1,2,3,4,5))
		mean(c(1,2,3,4,5))
		
		adams.sd <- function(x) {
			 y <- sqrt(sum((x-adams.mean(x))^2) / (length(x)-1))
			return(y)
			}
		
		adams.sd(c(1,2,3,4,5))
		sd(c(1,2,3,4,5))	

#----
#Bootstrapping 
	#generate some data
	A <- runif(100,10,20)
	# lets resample 50 elements from this data frame 100 times with replacement 
	ntimes<- 100
	nelem <- 100
	
	#setup a matrix to put the output into
	B <- matrix(NA,nrow=nelem,ncol=ntimes)
	
	#make a loop and fill in the matrix with resamples
	for(i in 1:ntimes) {
		B[,i] <- sample(A,size=nelem,replace=T)
	}
	#calculate sd
		#apply a function mean to all the columns (2) if I were to do this to rows it would be apply(B,1,sd)
		D <- apply(B,MARGIN=2,FUN=sd)
		hist(D)
		E <- mean(D)
		abline(v=E,col='red',lwd=5)
	


#if you have multiple functions saved in  a file named myfile.R which is already in your working directory

source('myfile.R')
ls() # look at the functions you have just read in

