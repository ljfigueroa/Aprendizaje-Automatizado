f_raw=open('toProm','r')
f_prom=open('promedioData','w')

e,v,t,tt = 0,0,0,0
i,j = 0,0
#f_prom.write('e,v,t,tt\n')
for line in f_raw:
    l = line.split(",")
    e += float(l[0])
    v += float(l[1])
    t += float(l[2])
    i += 1
    j += 1
    if i == 20:
        e /= 20
        v /= 20
        t /= 20
        tt /= 20
        if j==20:
            f_prom.write('5,'+str(e)+','+str(v)+','+str(t)+'\n')
        if j==40:
            f_prom.write('10,'+str(e)+','+str(v)+','+str(t)+'\n')
        if j==60:
            f_prom.write('15,'+str(e)+','+str(v)+','+str(t)+'\n')
        if j==80:
            f_prom.write('20,'+str(e)+','+str(v)+','+str(t)+'\n')
        if j==100:
            f_prom.write('25,'+str(e)+','+str(v)+','+str(t)+'\n')
        if j==120:
            f_prom.write('30,'+str(e)+','+str(v)+','+str(t)+'\n')
        i = 0
        e,v,t,tt = 0,0,0,0


