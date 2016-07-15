x<-read.csv("data.csv",header=FALSE)

for(i in c(1:4)) {
	print(paste(mean(x[,i]),sd(x[,i])))
}
