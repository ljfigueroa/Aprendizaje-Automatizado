library("ggplot2")

#data <- c(0.00000001,0.0000001,0.000001,0.00001,0.0001,0.001,0.01,0.1,1)
#names <- read.csv("data.csv",header=FALSE)

x = read.csv("datosArbol", header=F)
a = aggregate(x[x[,1]=='a',5:6], list(x[x[,1]=='a',2]), mean)
b = aggregate(x[x[,1]=='b',5:6], list(x[x[,1]=='b',2]), mean)
atrain = aes(y = V5, colour = "A Entrenamiento")
atest = aes(y = V6, colour = "A Árbol")
btrain = aes(y = V5, colour = "B Entrenamiento")
btest = aes(y = V6, colour = "B Árbol")

z = read.csv("A/promedioData", header=F,sep=",")
ab = aggregate(z[,3], list(z[,2]), mean)
abtest = aes(y = x, colour = "A Bayes")
z = read.csv("B/promedioData", header=F,sep=",")
bb = aggregate(z[,3], list(z[,2]), mean)
bbtest = aes(y = x, colour = "B Bayes")

#z = read.csv("datosRN", header=F,sep=",")
#ar = aggregate(z[,2], list(z[,1]), mean)
#artest = aes(y = x, colour = "A Red")
#z = read.csv("B/data.csv", header=F,sep=",")
#br = aggregate(z[,2], list(z[,1]), mean)
#brtest = aes(y = x, colour = "B Red")

z  = read.csv("datosRN", header=F,sep=",")
ar = aggregate(z[z[,1]=='a',2:3], list(z[z[,1]=='a',2]), mean)
br = aggregate(z[z[,1]=='b',2:3], list(z[z[,1]=='b',2]), mean)
artest = aes(y = V3, colour = "A Red")
brtest = aes(y = V3, colour = "B Red")

#c = aggregate(z[,4], list(seq(200,10000,200)), mean)
#ctest = aes(y = x, colour = "Test")
#a = aggregate(x[x[,1]=='a',5:6], list(x[x[,1]=='a',2]), mean)
#atest = aes(y = V6, colour = "A Test")


p<- ggplot(a, aes(Group.1)) +
  geom_point(atest) +
  geom_line(atest) +
  geom_point(data = b, btest) +
  geom_line(data = b, btest) +
  geom_point(data = ar, artest) +
  geom_line(data = ar, artest) +
  geom_point(data = br, brtest) +
  geom_line(data = br, brtest) +
  geom_point(data = ab, abtest) +
  geom_line(data = ab, abtest) +
  geom_point(data = bb, bbtest) +
  geom_line(data = bb, bbtest) +
 # geom_point(data = c, ctest) +
 # geom_line(data = c, ctest) +
  labs(y = "Error porcentual") +
  labs(x = "Cantidad de inputs") +
  labs(title = "Error") +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank()) +
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  #scale_y_continuous(breaks=c(5,10,15,20,25,30,35,40)) +
pdf("Error medio de test en árbol, red y bayes")
print(p)
dev.off()
