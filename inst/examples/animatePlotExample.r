#make simple animate example
animatePlotExample <- function() {
pdf('a.pdf',width=3.5,height=3.5)
	for(i in 1:100) {
		plot(1:10,i/100*1:10,xlim=c(0,10),ylim=c(0,10),xaxt='n',yaxt='n',type='l',xlab='',ylab='',bty='n')
	}
	dev.off()
print(paste('Plots are located in',getwd(),' and are called a.pdf'))
}
