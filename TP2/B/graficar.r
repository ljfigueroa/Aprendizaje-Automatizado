library("ggplot2")
z = read.csv("tograf", header=F,sep="\t")
a = aggregate(z[,7], list(seq(400,40000,400)), mean)
atest = aes(y = x, colour = "Error de test")
b = aggregate(z[,6], list(seq(400,40000,400)), mean)
btest = aes(y = x, colour = "Error de validación")
c = aggregate(z[,5], list(seq(400,40000,400)), mean)
ctest = aes(y = x, colour = "Error de train")
#a = aggregate(x[x[,1]=='a',5:6], list(x[x[,1]=='a',2]), mean)
#atest = aes(y = V6, colour = "A Test")


p<- ggplot(a, aes(Group.1)) +
  geom_point(atest) +
  geom_line(atest) +
  geom_point(data = b, btest) +
  geom_line(data = b, btest) +
  geom_point(data = c, ctest) +
  geom_line(data = c, ctest) +
  labs(y = "Error medio de clasificación") +
  labs(x = "Cantidad de épocas") +
  labs(title = "Errores en función de la cantidad de epocas") +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank()) +
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  #scale_y_continuous(breaks=c(5,10,15,20,25,30,35,40)) +
pdf("Errores en función de la cantidad de epocas")
print(p)
dev.off()
