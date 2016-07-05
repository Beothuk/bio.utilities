#' @export
#' @title convert.dd.dddd
#' @description This function can convert various formats to decimal degrees or to degrees-minutes
#' @param \code{x} = coordinates
#' @param \code{format} = dec.deg Acceptable values include dec.deg, deg.min
#' @author Brad Hubley 
#' @examples
#' convert.dd.dddd(4730.3)
#' [1] 47.505
#' convert.dd.dddd(47.505, 'deg.min')
#' [1] 4730.3
#' @family coordinate converters
#' @export
convert.dd.dddd<-function(x,format='dec.deg'){
	
	if(format=='dec.deg'){
		dat<-data.frame(ddmm.mm=x,dd.dddd=NA)
		
			#degrees-minutes-seconds -> degrees
			ddmmss<-dat$ddmm.mm[!is.na(dat$ddmm.mm)&abs(dat$ddmm.mm)>9000]
			ddmm.ss<-ddmmss/100
			ddmm<-trunc(ddmm.ss)
			ss<-(ddmm.ss-ddmm)*100
			dd.mm<-ddmm/100
			dd<-trunc(dd.mm)
			mm<-(dd.mm-dd)*100
			dat$dd.dddd[!is.na(dat$ddmm.mm)&abs(dat$ddmm.mm)>9000]<-dd+mm/60+ss/3600
		
			#degrees-minutes -> degrees
			dd.mmmm<-dat$ddmm.mm[!is.na(dat$ddmm.mm)&abs(dat$ddmm.mm)>90&abs(dat$ddmm.mm)<9000]/100
			dd<-trunc(dd.mmmm)
			mm.mm<-(dd.mmmm-dd)*100
			dat$dd.dddd[!is.na(dat$ddmm.mm)&abs(dat$ddmm.mm)>90&abs(dat$ddmm.mm)<9000]<-dd+mm.mm/60
	
			#degrees -> degrees
			dat$dd.dddd[!is.na(dat$ddmm.mm)&abs(dat$ddmm.mm)<90]<-dat$ddmm.mm[!is.na(dat$ddmm.mm)&abs(dat$ddmm.mm)<90]
		
		return(dat$dd.dddd)
	}
	
	if(format=='deg.min'){
		dat<-data.frame(ddmm.mm=NA,dd.dddd=x)
		
			#degrees-minutes-seconds -> degrees-minutes
			ddmmss<-dat$dd.dddd[!is.na(dat$dd.dddd)&abs(dat$dd.dddd)>9000]
			ddmm.ss<-ddmmss/100
			ddmm<-trunc(ddmm.ss)
			ss<-(ddmm.ss-ddmm)*100
			dat$ddmm.mm[!is.na(dat$dd.dddd)&abs(dat$dd.dddd)>9000]<-ddmm+ss/60
		
			#degrees-minutes -> degrees-minutes
			dat$ddmm.mm[!is.na(dat$dd.dddd)&abs(dat$dd.dddd)>90&abs(dat$dd.dddd)<9000]<-dat$dd.dddd[!is.na(dat$dd.dddd)&abs(dat$dd.dddd)>90&abs(dat$dd.dddd)<9000]

			#degrees -> degrees-minutes
			dd.dddd<-dat$dd.dddd[!is.na(dat$dd.dddd)&abs(dat$dd.dddd)<90]
			dd<-trunc(dd.dddd)
			mm.mm<-(dd.dddd-dd)*60
			dat$ddmm.mm[!is.na(dat$dd.dddd)&abs(dat$dd.dddd)<90]<-dd*100+mm.mm
	
		dat$ddmm.mm
	}
	
}

