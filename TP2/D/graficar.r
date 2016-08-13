library("ggplot2")

data <- c("0.00000001","0.0000001","0.000001","0.00001","0.0001","0.001","0.01","0.1","1")
names <- read.csv("data.csv",header=FALSE)

for (i in 1:9) {
z = read.csv(paste0("ssp-",data[i],"-",names[i,2],".mse") , header=F,sep="\t")
a = aggregate(z[,2], list(seq(200,100000,200)), mean)
atest = aes(y = x, colour = "Entrenamiento")
b = aggregate(z[,3], list(seq(200,100000,200)), mean)
btest = aes(y = x, colour = "Validación")
c = aggregate(z[,4], list(seq(200,100000,200)), mean)
ctest = aes(y = x, colour = "Test")
#a = aggregate(x[x[,1]=='a',5:6], list(x[x[,1]=='a',2]), mean)
#atest = aes(y = V6, colour = "A Test")


p<- ggplot(a, aes(Group.1)) +
  geom_point(atest) +
  geom_line(atest) +
 # geom_point(data = b, btest) +
 # geom_line(data = b, btest) +
  geom_point(data = c, ctest) +
  geom_line(data = c, ctest) +
  labs(y = "Mse medio") +
  labs(x = "Cantidad de épocas") +
  labs(title = paste0("Mse medio para Gamma ",data[i])) +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank()) +
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  #scale_y_continuous(breaks=c(5,10,15,20,25,30,35,40)) +
pdf(paste0("MSE - Gamma ",data[i]))
print(p)
dev.off()

}
