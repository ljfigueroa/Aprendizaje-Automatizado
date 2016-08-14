x <- read.csv("ejC.predic", header=FALSE , sep='\t')
pdf("ejC - k-vecinos.pdf")
plot(x[,1],x[,2],col=x[,3]+2,main='Gráfica de ejC.predic - 1-vecinos',xlab='input1',ylab='input2')
dev.off()

