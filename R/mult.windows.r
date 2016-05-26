mult.windows<-function(mars=par()$mar,mfrows=par()$mfrow) {
		graphics.off()
		if(exists(".SavedPlots",where=1)==T){rm(.SavedPlots,pos=1)}
		par(mar=mars,mfrow=mfrows)
		windows(record=T)
		}