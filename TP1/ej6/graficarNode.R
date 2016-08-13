library("ggplot2")
x = read.csv("file2", header=F)
a = aggregate(x[x[,1]=='a',5:6], list(x[x[,1]=='a',2]), mean)
b = aggregate(x[x[,1]=='b',5:6], list(x[x[,1]=='b',2]), mean)
atrain = aes(y = V5, colour = "A")
btrain = aes(y = V5, colour = "B")
p<- ggplot(a, aes(Group.1)) +
  geom_point(atrain) +
  geom_line(atrain) +
  geom_point(data = b, btrain) +
  geom_line(data = b, btrain) +
  labs(y = "Cantidad de nodos promedio") +
  labs(x = "Cantidad de puntos de entrenamiento") +
  labs(title = "Cantidad de nodos en el árbol After Pruning") +
  theme(legend.title=element_blank()) + 
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  scale_y_continuous(breaks=c(5,10,15,20,25,30)) +
  scale_color_manual(values=c("#CC6666", "#9999CC","#AC0000","#909990"))
pdf("Cantidad porcentual de nodos After Pruning")
print(p)
dev.off()

x = read.csv("file2", header=F)
a = aggregate(x[x[,1]=='a',3:4], list(x[x[,1]=='a',2]), mean)
b = aggregate(x[x[,1]=='b',3:4], list(x[x[,1]=='b',2]), mean)
atrain = aes(y = V3, colour = "A")
btrain = aes(y = V3, colour = "B")
p <- ggplot(a, aes(Group.1)) +
  geom_point(atrain) +
  geom_line(atrain) +
  geom_point(data = b, btrain) +
  geom_line(data = b, btrain) +
  labs(y = "Cantidad de nodos promedio") +
  labs(x = "Cantidad de puntos de entrenamiento") +
  labs(title = "Cantidad de nodos en el árbol Before Pruning") +
  theme(legend.title=element_blank()) + 
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  scale_y_continuous(breaks=c(5,10,15,20,25,30)) +
  scale_color_manual(values=c("#CC6666", "#9999CC","#AC0000","#909990"))
pdf("Cantidad porcentual de nodos Before Pruning")
print(p)
dev.off()
