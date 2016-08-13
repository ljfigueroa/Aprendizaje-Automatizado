library("ggplot2")

x = read.csv("file", header=F)
a = aggregate(x[x[,1]=='a',3:5], list(x[x[,1]=='a',2]), mean)
b = aggregate(x[x[,1]=='b',3:5], list(x[x[,1]=='b',2]), mean)
atrain = aes(y = V3, colour = "dos_elipses Entrenamiento")
aval = aes(y = V4, colour = "dos_elipses Validación")
atest = aes(y = V5, colour = "dos_elipses Test")
btrain = aes(y = V3, colour = "ejC Entrenamiento")
bval = aes(y = V4, colour = "ejC Validación")
btest = aes(y = V5, colour = "ejC Test")

#z = read.csv("A/data.csv", header=F,sep=",")
#ar = aggregate(z[,2], list(z[,1]), mean)
#artest = aes(y = x, colour = "A test - Red")
#z = read.csv("B/data.csv", header=F,sep=",")
#br = aggregate(z[,2], list(z[,1]), mean)
#brtest = aes(y = x, colour = "B test - Red")
#c = aggregate(z[,4], list(seq(200,10000,200)), mean)
#ctest = aes(y = x, colour = "Test")
#a = aggregate(x[x[,1]=='a',5:6], list(x[x[,1]=='a',2]), mean)
#atest = aes(y = V6, colour = "A Test")


p<- ggplot(a, aes(Group.1)) +
  geom_point(atrain) +
  geom_line(atrain) +
  geom_point(aval) +
  geom_line(aval) +
  geom_point(atest) +
  geom_line(atest) +
  geom_point(data = b, btrain) +
  geom_line(data = b, btrain) +
  geom_point(data = b, bval) +
  geom_line(data = b, bval) +
  geom_point(data = b, btest) +
  geom_line(data = b, btest) +
 # geom_point(data = c, ctest) +
 # geom_line(data = c, ctest) +
  labs(y = "Error promedio porcentual") +
  labs(x = "Cantidad de BINS") +
  labs(title = "Error") +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank()) +
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  #scale_y_continuous(breaks=c(5,10,15,20,25,30,35,40)) +
pdf("Error promedio segun la cantidad de BINS")
print(p)
dev.off()
