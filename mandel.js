// Generated by LiveScript 1.2.0
(function(){
  var print, mandelzahl, mandel;
  print = console.log;
  mandelzahl = function(cx, cy, max){
    var zx, zy, i, tx;
    zx = zy = 0.0;
    i = 0;
    while (++i <= max && zx * zx + zy * zy < 4) {
      tx = zx * zx - zy * zy + cx;
      zy = zx * zy * 2 + cy;
      zx = tx;
    }
    if (i > max) {
      return -1;
    } else {
      return i;
    }
  };
  mandel = function(w, h, max){
    var i$, step$, y, sb, j$, step1$, x, mz, results$ = [];
    for (i$ = -1.0, step$ = 2.0 / h; step$ < 0 ? i$ >= 1.0 : i$ <= 1.0; i$ += step$) {
      y = i$;
      sb = "";
      for (j$ = -2.0, step1$ = 3.0 / w; step1$ < 0 ? j$ >= 1.0 : j$ <= 1.0; j$ += step1$) {
        x = j$;
        mz = mandelzahl(x, y, max);
        if (mz > 0) {
          sb = sb + '-';
        } else {
          sb = sb + '*';
        }
      }
      results$.push(print(sb));
    }
    return results$;
  };
  mandel(140, 50, 10000);
  null;
}).call(this);
