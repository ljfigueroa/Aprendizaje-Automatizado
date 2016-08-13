library("ggplot2")
x = read.csv("file", header=F)
a = aggregate(x[x[,1]=='a',5:6], list(x[x[,1]=='a',2]), mean)
b = aggregate(x[x[,1]=='b',5:6], list(x[x[,1]=='b',2]), mean)
atrain = aes(y = V5, colour = "A Entrenamiento")
atest = aes(y = V6, colour = "A Test")
btrain = aes(y = V5, colour = "B Entrenamiento")
btest = aes(y = V6, colour = "B Test")
p<- ggplot(a, aes(Group.1)) +
  geom_point(atrain) +
  geom_point(atest) +
  geom_line(atrain) +
  geom_line(atest) +
  geom_point(data = b, btrain) +
  geom_point(data = b, btest) +
  geom_line(data = b, btrain) +
  geom_line(data = b, btest) +
  labs(y = "Error porcentual promedio") +
  labs(x = "Valor de d - Cantidad de inputs") +
  labs(title = "Error porcentual After Pruning") +
  theme(legend.title=element_blank()) +
  theme(legend.position = "bottom") +
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  #scale_x_continuous(breaks=c(2,4,8,16,32)) +
  scale_x_continuous(breaks=a[,1]) +
  #scale_color_manual(values=c("#CC6666", "#9999CC","#AC0000","#909990"))
pdf("Error porcentual After Pruning")
print(p)
dev.off()

x = read.csv("file", header=F)
a = aggregate(x[x[,1]=='a',3:4], list(x[x[,1]=='a',2]), mean)
b = aggregate(x[x[,1]=='b',3:4], list(x[x[,1]=='b',2]), mean)
atrain = aes(y = V3, colour = "A Entrenamiento")
atest = aes(y = V4, colour = "A Test")
btrain = aes(y = V3, colour = "B Entrenamiento")
btest = aes(y = V4, colour = "B Test")
p <- ggplot(a, aes(Group.1)) +
  geom_point(atrain) +
  geom_point(atest) +
  geom_line(atrain) +
  geom_line(atest) +
  geom_point(data = b, btrain) +
  geom_point(data = b, btest) +
  geom_line(data = b, btrain) +
  geom_line(data = b, btest) +
  labs(y = "Error porcentual promedio") +
  labs(x = "Cantidad de puntos de entrenamiento") +
  labs(title = "Error porcentual Before Pruning") +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank()) +
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  scale_x_continuous(breaks=a[,1]) +
  scale_color_manual(values=c("#CC6666", "#9999CC","#AC0000","#909990"))
pdf("Error porcentual Before Pruning")
print(p)
dev.off()
