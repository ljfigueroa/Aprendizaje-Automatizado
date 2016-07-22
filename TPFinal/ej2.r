x <- read.csv("tabla.csv")

fst  = 3
snd  = 1
last = 2
k    = 10
conf = 2.26 # 95% de confidencia y  v=9 (k-1)

resta1 = x[,fst][1:k] - x[,last][1:k]
resta2 = x[,fst][1:k] - x[,snd][1:k]

d1 = sum(resta1) / k
d2 = sum(resta2) / k

rango1 = sqrt( 1/(k*(k-1)) * sum((resta1-d1)**2) )
rango2 = sqrt( 1/(k*(k-1)) * sum((resta2-d2)**2) )

cat("Mejor vs Peor: ", d1," +- ",conf * rango1,"\n")
cat("Mejor vs Segundo Mejor: ", d2," +- ",conf * rango2,"\n")
