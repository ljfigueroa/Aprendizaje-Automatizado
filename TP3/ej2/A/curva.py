import math

def norma(v,clase):
    res = 0
    i = 0
    for i in range(len(v)):
        res += (v[i] - clase[i])**2

    return math.sqrt(res)


def fClase(line):
    svector = len(line)-1
    v = map(float,line[0:svector])
    clase1 = [1 for i in range(svector)]
    clase0 = [-1 for i in range(svector)]

    if norma(v,clase0) > norma(v,clase1):
        return 1
    else:
        return 0

def main():

    f_prom=open('promedioCurva','w')
    conjuntos = ["2","4","8","16","32"]
    for s in conjuntos:
        filename="ejA-"+s+"-15.test"
        f = open(filename,'r')
        error = 0
        for line in f:
            l = line.split(",")
            #print l[len(l)-1]
            if fClase(l) != int(l[len(l)-1]):
                error += 1

        #print error
        err_porcentual = float(error * 100) / 10000
        f_prom.write("a,"+s+","+str(err_porcentual)+"\n")

if __name__ == "__main__":
    main()
