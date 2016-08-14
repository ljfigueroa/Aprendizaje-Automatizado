def fClase(line):
    if float(line[0]) > 0:
        return 1
    else:
        return 0

def main():

    f_prom=open('promedioCurva','w')
    conjuntos = ["2","4","8","16","32"]
    for s in conjuntos:
        filename="ejB-"+s+"-15.test"
        f = open(filename,'r')
        error = 0
        for line in f:
            l = line.split(",")
            #print l[]
            if fClase(l) != int(l[len(l)-1]):
                error += 1
    
        #print error
        err_porcentual = float(error * 100) / 10000
        f_prom.write("b,"+s+","+str(err_porcentual)+"\n")

if __name__ == "__main__":
    main()
