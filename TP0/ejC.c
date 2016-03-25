#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

typedef struct {
	double x;
	double y;
} point;

double double_random_between(double min, double max) {
	double r = drand48();
	return min + r * (max - min);
}


point entre_curvas(int clase)
{
	double r,x,y,phi,phi1,phi2,r1,r2,at;
	point p;
	int i;
	
	for(;;) {
		for(;;) {
			x = double_random_between(-1.0,1.0);
			y = double_random_between(-1.0,1.0);
			r = sqrt(pow(x,2) + pow(y,2));
			if (r <= 1)
				break;
		}
		phi = atan2(y,x);
		at = phi;
		
		r1 = phi / (4 * M_PI);
		r2 = (phi + M_PI) / (4 * M_PI);
		
		p.x = x;
		p.y = y;
		if (clase == 0) {
			for (i=0; i <= 2; i++) {
				phi = at + M_PI*(2*i);
				r1 = phi / (4 * M_PI);
				r2 = (phi + M_PI) / (4 * M_PI);
				if (r1 < r && r < r2)
					return p;
			}
		}
		else {
			for (i=0; i <= 2; i++) {
				phi1 = at + M_PI*(2*i);
				phi2 = phi1+ M_PI*2;
				r1 = phi2 / (4 * M_PI);
				r2 = (phi1 + M_PI) / (4 * M_PI);
				if (r1 > r && r > r2)
					return p;
				else {
					r1 = at / (4 * M_PI);
					if (r1 > r)
						return p;
				}	
									
			}
		}
	}
}


int main()
{
  	int n, i,clase;
	double u;
	FILE *f;
	point p;
	
	f = fopen("test3.csv", "w");
	//scanf("%d", &n);
	n = 10000;
	srand(time(NULL));
	for (clase=0; clase < 2 ;clase++) {
		for (i=0; i < n/2 ;i++) {
			p = entre_curvas(clase);
			fprintf(f, "%lf, %lf, %d\n",p.x,p.y,clase);
		}
	}

	return 0;
}
