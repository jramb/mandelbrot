/**
 * Mandebrot set in Dart
 * 2013,2018 jramb
 */

//old//import 'dart:io' as io; // commandline uses "io", web uses "html"
import 'dart:async';


int mandelzahl(double cx, double cy, int max) {
  num zx = 0.0, zy = 0.0; // this is fastest
  int i = 0;
  // num zx = cx + 0, zy = cy + 0; // the +0 makes this faste, why???
  // int i = 1;
  num x2, y2;
  while (i++ <= max && ((x2 = zx * zx) + (y2 = zy * zy)) < 4.0) {
    // z -> z^2 +c
    /*num tx = zx*zx - zy*zy + cx;*/
    zy = zx * zy * 2 + cy;
    zx = x2 - y2 + cx;
  }
  return i > max ? -1 : i;
}

StringBuffer mandelline(int w, double y, int max) {
  var char_a = "a".codeUnitAt(0);
  StringBuffer sb = new StringBuffer();
  double x;
  for (x = -2.0; x < 1.0; x += 3.0 / w) {
    var mz = mandelzahl(x, y, max);
    if (mz > 0) {
      sb.writeCharCode(char_a + (mz % 26) - 1); //stdout.write(' ');
    } else {
      sb.write(' '); //stdout.write('*');
    }
  }
  return sb;
}

Stream<StringBuffer> alllines(int w, int h, int max) async* {
  double y;
  for (y = 1.0; y >= -1.0; y -= 2.0 / h) {
    yield mandelline(w, y, max);
  }
}

Future mandel(int w, int h, int max) async {
  var al = alllines(w, h, max);
  await for (var sb in al) {
    print(sb);
  }
}

typedef void callback(); // or "Functione exec()" in the parameter list

Future<Duration> time(callback exec) async {
  var stw = new Stopwatch();
  stw.start();
  await exec();
  stw.stop();
  print("Execution time: ${stw.elapsed}");
  // int timeStart = new DateTime.now().millisecondsSinceEpoch;
  // exec();
  // int timeEnd = new DateTime.now().millisecondsSinceEpoch;
  // print("Execution time: ${(timeEnd-timeStart)/1000.0}");
  return stw.elapsed;
}

void main(List<String> argv) {
  //List<String> argv = (new io.Options()).arguments;
  List<int> argvi;
  if (argv.length == 0) {
    argvi = [140, 50, 100000];
  } else {
    argvi = argv.map((e) => int.parse(e)).toList();
  }
  print("Mandel: $argvi");
  time(() => mandel(argvi[0], argvi[1], argvi[2]));
}
