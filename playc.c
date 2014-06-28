	/* C-Programm zur Erzeugung von Bildern aus der */
	/* 	Mandelbrotmenge									*/
	/*		5/91 von O. Linnemann	*/
/* minimal changes by jramb */
/* compiled with: gcc playc.c -O2 -o playc */

#include <math.h>
#include <stdio.h>
#include <time.h>
//#include <CONSOLE.H>				// enthält STDIO.H
//#include "GRAFWINDOW.H"

//#define CLRSCRN()	{ cgotoxy(1,1,stdout); ccleos(stdout); }
#define SQUARE(x)	((x)*(x))

typedef	double	REAL;	 /* zur Berechnung verwendeter Typ */

REAL		Realmin, Imagmin, Breite, Hoehe;
int		Bx,By,Tiefe;

erz_bild()
{
	int 	x,y,zaehler;
	REAL	z,zi,c,ci,temp;
  //no improvement//REAL  z2,zi2;

	putchar('\n');
	for(y=0;y<By;++y)
	{
		for(x=0;x<Bx;++x)
		{
			//z=0; zi=0; zaehler=0;
			z=c; zi=ci; zaehler=1;
			c=Realmin + x*Breite/Bx; ci=Imagmin + y*Hoehe/By;
      //z2=SQUARE(z); zi2=SQUARE(zi);
			do	{
				temp=SQUARE(z)-SQUARE(zi)+c;
				//temp=z2-zi2+c;
				zi=2*z*zi + ci;
				z=temp;
        //z2=SQUARE(z); zi2=SQUARE(zi);
			 //} while((z2+zi2)<4.0 && ++zaehler<Tiefe);
			} while((SQUARE(z)+SQUARE(zi))<4 && ++zaehler<Tiefe);
			if(zaehler==Tiefe)
      { putchar('*'); }
      else
      { putchar('-'); }

		}
		putchar('\n');
	}
}

eingabe()
{
	//CLRSCRN();
#ifdef _DO_NOT
	printf("\t\tProgramm zur Erzeugung von Bildern\n");
	printf("\t\t     aus der Mandelbrotmenge\n");
	printf("\t\t      5/90 von O. Linnemann\n\n");
	printf("Geben Sie die Koordinaten des linken oberen Eckpunktes\n");
	printf("und die Seitenlänge des zu berechnenden Bereiches ein:\n");
	printf("REALTEIL:\t"); scanf("%lf",&Realmin);
	printf("IMAGINÄRTEIL:\t"); scanf("%lf",&Imagmin);
	printf("SEITENLÄNGE:\t"); scanf("%lf",&Breite);
	putchar('\n'); printf("SUCHTIEFE:\t"); scanf("%d",&Tiefe);
	printf("\n");
	printf("Geben Sie die Breite und die Höhe des Bildausschnittes an:\n");
	printf("BREITE:\t"); scanf("%d",&Bx);
	printf("HÖHE:\t"); scanf("%d",&By);
#endif
  Realmin = -2.0;
  Imagmin = -1.0;
  Breite = 3.0;
  Hoehe = 2.0;
  Bx = 140;
  By = 50;
  Tiefe = 100000;
}

main()
{
  clock_t t1, t2;
	eingabe();
	// OpenGrafWindow();
  t1 = clock();
	erz_bild();
  t2 = clock();
  printf("\n%lf seconds\n", (t2-t1) / (double)CLOCKS_PER_SEC );
	// waitUntilKlick();
	// DisposeGrafWindow();
}
