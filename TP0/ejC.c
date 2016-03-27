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

double ro1(double theta)
{
	return theta / (4 * M_PI);
}

double ro2(double theta)
{
	return (theta + M_PI) / (4 * M_PI);
}

point entre_curvas(int clase)
{
	int i;
	point p;
	double r, x, y, phi1, phi2, r1, r2, p_angulo;
		
	for(;;) {
		for(;;) {
			x = double_random_between(-1.0,1.0);
			y = double_random_between(-1.0,1.0);
			r = sqrt(pow(x,2) + pow(y,2));
			if (r <= 1)
				break;
		}
		p_angulo = atan2(y,x);

		p.x = x;
		p.y = y;

		if (clase == 1) {
			for (i=0; i <= 2; i++) {
				phi1 = p_angulo + M_PI*(2*i);
				r1 = ro1(phi1);
				r2 = ro2(phi1);
				if (r1 < r && r < r2)
					return p;
			}
		}
		else {
			for (i=0; i <= 2; i++) {
				phi1 = p_angulo + M_PI*(2*i);
				phi2 = phi1+ M_PI*2;
				r1 = ro1(phi2);
				r2 = ro2(phi1);
				if (r1 > r && r > r2)
					return p;
				else {
					r1 = ro1(p_angulo);
					if (r1 > r)
						return p;
				}	
									
			}
		}
	}
}


int main()
{
	point p;
  	int n, i,clase;
	FILE *dfile, *nfile;
	char clase1[] = "clase1";
	char clase0[] = "clase0";
	
	dfile = fopen("ejC.data", "w");
	nfile = fopen("ejC.names", "w");

	scanf("%d", &n);
	srand48(time(NULL));

	/* Genero el .data */
	for (clase=0; clase < 2 ;clase++) {
		for (i=0; i < n/2 ;i++) {
			p = entre_curvas(clase);
			fprintf(dfile, "%lf, %lf, %s\n", p.x, p.y,
				clase == 0 ? clase0 : clase1);
		}
	}
	fclose(dfile);

	/* Genero el .names */
	fprintf(nfile, "clase0, clase1.\n\n");
	fprintf(nfile, "input1: continuous.\n");
	fprintf(nfile, "input2: continuous.\n");
	fclose(nfile);

	return 0;
}
