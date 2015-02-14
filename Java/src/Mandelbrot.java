// 2015 by J.Ramb for his Mandelbrot-Zoo
// package none

class Mandelbrot {

  private static int depth(Double cx, Double cy, int max) {
    Double zx, zy, x2, y2;
    int i = -1;
    zx = cx;
    zy = cy;
    while (++i <= max && (x2 = zx * zx) + (y2 = zy * zy) < 4) {
      zy = zx * zy * 2 + cy;
      zx = x2 - y2 + cx;
    }
    return i;
  }

  private static char depth2Char(int d) {
    return (char) (((int)'a') + (d % 26));
  }

  private static void mandelbrot(int w, int h, int max) {
    Double x,y;
    Double stepX = 3.0/w;
    Double stepY = 2.0/h;

    // yeah, negative y is up, but who will spot that??
    for(y=-1.0; y<1.0; y += stepY) {
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

    System.out.println("Mandelbrot");
    System.out.println(w+" x "+h+", max = "+max);
    mandelbrot(w,h,max);
  }

}

