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
    var stepY, sb, x, stepX, x, mz;
    var c_char = "a".charCodeAt(0);
    for (y = -1.0, stepY = 2.0 / h; y <= 1.0; y += stepY) {
      sb = "";
      for (x = -2.0, stepX = 3.0 / w; x <= 1.0; x += stepX) {
        mz = mandelzahl(x, y, max);
        if (mz>0) {
            sb += String.fromCharCode(c_char + mz%26 - 1);
        } else {
            sb += '.';
        }
      }
      print(sb);
    }
  };
  mandel(140, 50, 100000);
}).call(this);
