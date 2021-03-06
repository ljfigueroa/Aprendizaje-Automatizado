library("ggplot2")

#data <- c(0.00000001,0.0000001,0.000001,0.00001,0.0001,0.001,0.01,0.1,1)
#names <- read.csv("data.csv",header=FALSE)

x = read.csv("file", header=F)
a = aggregate(x[x[,1]=='a',5:6], list(x[x[,1]=='a',2]), mean)
b = aggregate(x[x[,1]=='b',5:6], list(x[x[,1]=='b',2]), mean)
atrain = aes(y = V5, colour = "A Entrenamiento")
atest = aes(y = V6, colour = "A Test - Árbol")
btrain = aes(y = V5, colour = "B Entrenamiento")
btest = aes(y = V6, colour = "B Test - Árbol")

z = read.csv("A/data.csv", header=F,sep=",")
ar = aggregate(z[,2], list(z[,1]), mean)
artest = aes(y = x, colour = "A test - Red")
z = read.csv("B/data.csv", header=F,sep=",")
br = aggregate(z[,2], list(z[,1]), mean)
brtest = aes(y = x, colour = "B test - Red")
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
 # geom_point(data = c, ctest) +
 # geom_line(data = c, ctest) +
  labs(y = "Error porcentual") +
  labs(x = "Cantidad de inputs") +
  labs(title = "Error") +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank()) +
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  #scale_y_continuous(breaks=c(5,10,15,20,25,30,35,40)) +
pdf("Error medio de test en árbol y red")
print(p)
dev.off()
