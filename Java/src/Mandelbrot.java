// 2015 by J.Ramb for his Mandelbrot-Zoo
// package none

class Mandelbrot {
  /*
 private static final int depth(double cx, double cy, int max)
  {
    double zx = 0.0D;
    double zy = 0.0D;
    int i = -1;
    double x2 = 0.0D;
    double y2 = 0.0D;
    for (;;)
    {
      i++;
      if ((i > max) || (x2 + y2 >= 4)) {
        break;
      }
      zy = zx * zy * 2.0D + cy;
      zx = x2 - y2 + cx;
      x2 = zx * zx;
      y2 = zy * zy;
    }
    return i;
  }
  */
  private static final int depth(double cx, Double cy, int max) {
    double zx, zy, x2, y2;
    int i = -1;
    zx = cx;
    zy = cy;
    while (++i <= max && (x2 = zx * zx) + (y2 = zy * zy) < 4) {
      zy = zx * zy * 2 + cy;
      zx = x2 - y2 + cx;
    }
    return i;
  }

  private static final char depth2Char(int d) {
    return (char) (((int)'a') + (d % 26));
  }

  private static final void mandelbrot(int w, int h, int max) {
    double x,y;
    double stepX = 3.0/w;
    double stepY = 2.0/h;

    for(y=1.0; y>=-1.0; y -= stepY) {
      for(x=-2.0; x<1.0; x+= stepX) {
        int d = depth(x,y,max);
        //System.out.print(d>max? '*' : '-');
        System.out.print(d>max? ' ' : depth2Char(d));
      }
      System.out.println();
    }
  }

  public static void main(String[] args) {
    int w = Integer.parseInt(args[0]);
    int h = Integer.parseInt(args[1]);
    int max = Integer.parseInt(args[2]);

    mandelbrot(w,h,max);
    System.out.println(w+" x "+h+", max = "+max);
  }

}

