loadfunctions(c('utility','groundfish'))
  p = list()

p$init.files = loadfunctions( "groundfish", functionname="load.groundfish.environment.r") 

d = groundfish.db(DS='gscat',p=p)
n = structure(list(spec = c("10", "11", "12", "14", "15", "16", "23", 
"30", "40", "41", "42", "43", "31", "13"), names = c("Atlantic cod", 
"Haddock", "White Hake", "Silver hake", "Cusk", "Pollock", "Redfish", 
"Halibut", "American plaice", "Witch flounder", "Yellowtail flounder", 
"Winter flounder", "Greenland halibut", "Red hake")), .Names = c("spec", 
"names"), row.names = c(NA, -14L), class = "data.frame")

d <- d[which(d$spec %in% n[,'spec']),]

#add in the species names 

#Method 1 using ifelse statements
d1=d
d1$names = ifelse(d1$spec== 10 ,'Atlantic cod',ifelse(d1$spec== 11 ,'Ha(ddock',ifelse(d1$spec== 12 ,'White Hake',
	ifelse(d1$spec== 14 ,'Silver hake',ifelse(d1$spec== 15 ,'Cusk',ifelse(d1$spec== 16 ,'Pollock',
		ifelse(d1$spec== 23 ,'Redfish',ifelse(d1$spec== 30 ,'Halibut',ifelse(d1$spec== 40 ,'American plaice',
			ifelse(d1$spec== 41 ,'Witch flounder',ifelse(d1$spec== 42 ,'Yellowtail flounder',
				ifelse(d1$spec== 43 ,'Winter flound1er',ifelse(d1$spec== 31 ,'Greenland halibut',ifelse(d1$spec== 13 ,'Red hake','No Idea'))))))))))))))

#Method 2 using recode function

d2 = d
d2$names = recode(d2$spec,"10 ='Atlantic cod'; 11 ='Haddock'; 12 ='White Hake'; 14 ='Silver hake'; 
	15 ='Cusk'; 16 ='Pollock'; 23 ='Redfish'; 30 ='Halibut'; 40 ='American plaice'; 
	41 ='Witch flounder'; 42 ='Yellowtail flounder'; 43 ='Winter flounder'; 31 ='Greenland halibut'; 13 ='Red hake'")

#Method 3 using merge function

d3 = merge(d,n,by='spec',all.x=T)
n1 <- n[1:3,]
d5 = merge(d,n1,by='spec')

#method 4 using sqldf
require(sqldf)

d4 = sqldf('select id, id2,d.spec,totno, sampwgt,n.names from d, n where d.spec=n.spec')

#there are probably more but here a few options to consider

d$names =NA
d[which(d$spec==10),'names'] <- "Atlantic cod"
d[which(d$spec==11),'names'] <- "Haddock"
