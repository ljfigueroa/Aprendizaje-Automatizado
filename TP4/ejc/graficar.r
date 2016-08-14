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
ak     = aggregate(z[z[,3]=='0',3:4], list(z[z[,3]=='0',2]), mean)
aktest = aes(y = V4, colour = "A knn")
a1     = aggregate(z[z[,3]=='1',3:4], list(z[z[,3]=='1',2]), mean)
a1test = aes(y = V4, colour = "A 1nn")
z = read.csv("B/promedioData", header=F,sep=",")
bk     = aggregate(z[z[,3]=='0',3:4], list(z[z[,3]=='0',2]), mean)
bktest = aes(y = V4, colour = "B knn")
b1     = aggregate(z[z[,3]=='1',3:4], list(z[z[,3]=='1',2]), mean)
b1test = aes(y = V4, colour = "B 1nn")


z  = read.csv("datosRN", header=F,sep=",")
ar = aggregate(z[z[,1]=='a',2:3], list(z[z[,1]=='a',2]), mean)
br = aggregate(z[z[,1]=='b',2:3], list(z[z[,1]=='b',2]), mean)
artest = aes(y = V3, colour = "A Red")
brtest = aes(y = V3, colour = "B Red")

z  = read.csv("datosBN", header=F,sep=",")
ab = aggregate(z[z[,1]=='a',2:3], list(z[z[,1]=='a',2]), mean)
bb = aggregate(z[z[,1]=='b',2:3], list(z[z[,1]=='b',2]), mean)
abtest = aes(y = V3, colour = "A Bayes")
bbtest = aes(y = V3, colour = "B Bayes")


p<- ggplot(a, aes(Group.1)) +
  geom_point(data = ak, aktest) +
  geom_line(data = ak, aktest) +
  geom_point(data = a1, a1test) +
  geom_line(data = a1, a1test) +
  geom_point(data = bk, bktest) +
  geom_line(data = bk, bktest) +
  geom_point(data = b1, b1test) +
  geom_line(data = b1, b1test) +
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
  labs(y = "Error porcentual promedio") +
  labs(x = "Cantidad de inputs") +
  labs(title = "Error de test") +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank()) +
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  scale_x_continuous(breaks=c(2,4,8,16,32)) +
pdf("Error medio de test en árbol, red, bayes y k-vecinos.pdf")
print(p)
dev.off()
