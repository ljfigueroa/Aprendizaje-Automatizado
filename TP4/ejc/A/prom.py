f_raw=open('toProm','r')
f_prom=open('promedioData','w')

bp,bpt,ap,apt = 0,0,0,0
i,j = 0,0
#f_prom.write('bp,bpt,ap,apt\n')
for line in f_raw:
    l = line.split(",")
    bp += float(l[0])
    i += 1
    j += 1
    if i == 20:
        bp /= 20
        bpt /= 20
        ap /= 20
        apt /= 20
        if j==20:
            f_prom.write('a,2,0,'+str(bp)+'\n')
        if j==40:
            f_prom.write('a,4,0,'+str(bp)+'\n')
        if j==60:
            f_prom.write('a,8,0,'+str(bp)+'\n')
        if j==80:
            f_prom.write('a,16,0,'+str(bp)+'\n')
        if j==100:
            f_prom.write('a,32,0,'+str(bp)+'\n')
        if j==120:
            f_prom.write('a,2,1,'+str(bp)+'\n')
        if j==140:
            f_prom.write('a,4,1,'+str(bp)+'\n')
        if j==160:
            f_prom.write('a,8,1,'+str(bp)+'\n')
        if j==180:
            f_prom.write('a,16,1,'+str(bp)+'\n')
        if j==200:
            f_prom.write('a,32,1,'+str(bp)+'\n')
        i = 0
        bp,bpt,ap,apt = 0,0,0,0


