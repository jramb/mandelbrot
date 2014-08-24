#!/usr/bin/env groovy
// 2014, hacked together with NO good knowledge of Groovy, really
//println "Hello from the shebang line"

int mandelzahl(double cx, double cy, int max) {
    //double zx, zy, x2, y2;
    double zx = cx;
    double zy = cy;
    i = 1;
    while (++i <= max && (x2 = zx * zx) + (y2 = zy * zy) < 4.0) {
      zy = zx * zy * 2.0 + cy;
      zx = x2 - y2 + cx;
    }
    return (i > max)? -1 : i
}

assert 6 == mandelzahl(0.5, 0.5, 100);


void mandel(int w, int h, int max) {
    double step = 2.0 / h, step1 = 3.0 / w
    for (y = -1.0; y <= 1.0; y += step) {
      sb = "";
      for (x = -2.0; x <= 1.0; x += step1) {
        sb += mandelzahl(x, y, max) > 0 ? '-' : '*';
      }
      println sb;
    }
}

mandel(140,50, 1e5 as int)

