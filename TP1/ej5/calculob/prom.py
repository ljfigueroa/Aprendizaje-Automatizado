f_raw=open('toProm','r')
f_prom=open('promedioData','w')
 
bp,bpt,ap,apt = 0,0,0,0
i,j = 0,0
#f_prom.write('bp,bpt,ap,apt\n')
for line in f_raw:
    l = line.split(",")
    bp += float(l[0])
    bpt+= float(l[1])
    ap += float(l[2])
    apt += float(l[3])
    i += 1
    j += 1
    if i == 20:
        bp /= 20
        bpt /= 20
        ap /= 20
        apt /= 20
        if j==20:
            f_prom.write('b,100,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        if j==40:
            f_prom.write('b,200,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        if j==60:
            f_prom.write('b,300,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        if j==80:
            f_prom.write('b,500,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        if j==100:
            f_prom.write('b,1000,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        if j==120:
            f_prom.write('b,5000,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        i = 0
        bp,bpt,ap,apt = 0,0,0,0


f_raw=open('toPromNodes','r')
f_prom=open('promedioNodes','w')
bp,bpt,ap,apt = 0,0,0,0
i,j = 0,0
for line in f_raw:
    l = line.split(",")
    bp += float(l[0])
    bpt+= float(l[1])
    ap += float(l[2])
    apt += float(l[3])
    i += 1
    j += 1
    if i == 20:
        bp /= 20
        bpt /= 20
        ap /= 20
        apt /= 20
        if j==20:
            f_prom.write('b,100,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        if j==40:
            f_prom.write('b,200,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        if j==60:
            f_prom.write('b,300,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        if j==80:
            f_prom.write('b,500,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        if j==100:
            f_prom.write('b,1000,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        if j==120:
            f_prom.write('b,5000,'+str(bp)+','+str(bpt)+','+str(ap)+','+str(apt)+'\n')
        i = 0
        bp,bpt,ap,apt = 0,0,0,0
