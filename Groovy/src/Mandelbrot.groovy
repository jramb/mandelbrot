#!/usr/bin/env groovy
// 2014, hacked together with NO good knowledge of Groovy, really
//println "Hello from the shebang line"

int depth(double cx, double cy, int max) {
    double x2, y2
    double zx = cx
    double zy = cy
    int i = -1
    while (++i <= max && (x2 = zx * zx) + (y2 = zy * zy) < 4.0) {
      zy = zx * zy * 2.0 + cy
      zx = x2 - y2 + cx
    }
    i
}

//assert 6 == depth(0.5, 0.5, 100);


char depth2Char(int d) {
  (char) (((int)'a') + (d % 26));
}

def mandelbrot(int w, int h, int max) {
    double stepY = 2.0 / h, step1 = 3.0 / w
    for (y = -1.0; y < 1.0; y += stepY) {
      sb = "";
      for (x = -2.0; x < 1.0; x += step1) {
        d = depth x,y,max
        sb += d > max ? ' ' : depth2Char(d)
      }
      println sb;
    }
}

w = Integer.parseInt args[0];
h = Integer.parseInt args[1];
max = Integer.parseInt args[2];
mandelbrot(w,h, max as int)
println args

