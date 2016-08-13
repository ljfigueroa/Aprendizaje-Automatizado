library("ggplot2")
z = read.csv("tograf", header=F,sep="\t")
a = aggregate(z[,2], list(seq(50,10000,50)), mean)
atest = aes(y = x, colour = "Entrenamiento")
b = aggregate(z[,3], list(seq(50,10000,50)), mean)
btest = aes(y = x, colour = "Validación")
c = aggregate(z[,4], list(seq(50,10000,50)), mean)
ctest = aes(y = x, colour = "Test")
#a = aggregate(x[x[,1]=='a',5:6], list(x[x[,1]=='a',2]), mean)
#atest = aes(y = V6, colour = "A Test")


p<- ggplot(a, aes(Group.1)) +
  geom_point(atest) +
  geom_line(atest) +
  geom_point(data = b, btest) +
  geom_line(data = b, btest) +
  geom_point(data = c, ctest) +
  geom_line(data = c, ctest) +
  labs(y = "Mse") +
  labs(x = "Cantidad de épocas") +
  labs(title = "190 datos de entrenamiento") +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank()) +
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  #scale_y_continuous(breaks=c(5,10,15,20,25,30,35,40)) +
pdf("MSE - 190 datos de entrenamiento")
print(p)
dev.off()
