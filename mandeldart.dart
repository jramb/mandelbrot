/**
 * Mandebrot set in Dart
 * 2013 jramb
 */

import 'dart:io' as io; // commandline uses "io", web uses "html"

int mandelzahl(double cx, double cy, int max) {
  num zx=0.0, zy=0.0;
  int i=0;
  while(i<=max && (zx*zx+zy*zy)<4) {
    // z -> z^2 +c
    num tx = zx*zx - zy*zy + cx;
    zy = zx*zy*2 + cy;
    zx = tx;
    i++;
  }
  return i>max?-1:i;
}


void mandel(int w, int h, int max) {
  double x, y;
  for(y=1.0 ; y>=-1.0 ; y-=2.0/h) {
    StringBuffer sb = new StringBuffer();
    for(x=-2.0 ; x<1.0 ; x+=3.0/w) {
      var mz = mandelzahl(x,y,max);
      if (mz>0) {
        sb.write('-');//stdout.write(' ');
      } else {
        sb.write('*');//stdout.write('*');
      }
    }
    print(sb);//stdout.writeln();
  }
}


typedef void callback(); // or "Functione exec()" in the parameter list

void time(callback exec) {
  int timeStart = new DateTime.now().millisecondsSinceEpoch;
  exec();
  int timeEnd = new DateTime.now().millisecondsSinceEpoch;
  print("Execution time: ${(timeEnd-timeStart)/1000.0}");
}

void main(List<String> argv) {
  //List<String> argv = (new io.Options()).arguments;
  List<int> argvi;
  if (argv.length==0) {
    argvi = [140, 50, 100000];
  } else {
    argvi = argv.map((e) => int.parse(e)).toList();
  }
  print("Mandel: $argvi");
  time(()=>
    mandel(argvi[0],argvi[1],argvi[2]));
 }
