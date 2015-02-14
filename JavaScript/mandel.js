// Generated by LiveScript 1.2.0
/* 2014 by JRamb */
(function(){
  var print, mandelzahl, mandel;
  if (typeof Packages === "object") {
    print = function(it){
      return java.lang.System.out.println(it);
    };
  } else {
    print || (print = console.log);
  }
  mandelzahl = function(cx, cy, max){
    /* z -> z^2 + c */
    var zx, zy, i, x2, y2;
    zx = cx;
    zy = cy;
    i = 1;
    while (++i <= max && (x2 = zx * zx) + (y2 = zy * zy) < 4) {
      zy = zx * zy * 2 + cy;
      zx = x2 - y2 + cx;
    }
    if (i > max) {
      return -1;
    } else {
      return i;
    }
  };
  mandel = function(w, h, max){
    var i$, step$, y, sb, j$, step1$, x, mz;
    for (i$ = -1.0, step$ = 2.0 / h; step$ < 0 ? i$ >= 1.0 : i$ <= 1.0; i$ += step$) {
      y = i$;
      sb = "";
      for (j$ = -2.0, step1$ = 3.0 / w; step1$ < 0 ? j$ >= 1.0 : j$ <= 1.0; j$ += step1$) {
        x = j$;
        mz = mandelzahl(x, y, max);
        sb += mz > 0 ? '-' : '*';
      }
      print(sb);
    }
  };
  mandel(140, 50, 100000);
}).call(this);