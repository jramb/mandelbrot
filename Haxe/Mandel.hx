class Mandel {
  // 2016-12-01 by jramb, my first Haxe program

  static function mandelzahl(cx:Float, cy: Float, max:Int):Int {
    var zx:Float, zy:Float, x2:Float, y2:Float;
    var i:Int;
    zx = cx;
    zy = cy;
    i = 1;
    while (++i <= max && (x2 = zx * zx) + (y2 = zy * zy) < 4.0) {
      zy = zx * zy * 2 + cy;
      zx = x2 - y2 + cx;
    }
    if (i > max) {
      return -1;
    } else {
      return i;
    }
  }

  static function mandel(?w=140, ?h=50, ?max=100000){
    trace('Mandel $w x $h in $max');
    var sb: StringBuf;
    var stepX = 3.0 / w, stepY = 2.0/h;
    var x:Float, mz:Int;
    var y = -1.0;
    for(iy in 0...h) {
      sb = new StringBuf(); // make StringBuf with a predefined size?
      x = -2.0;
      for( ix in 0...w) {
      //while( x <= 1.0 ) {
        mz = mandelzahl(x,y,max);
        //sb += String.fromCharCode(mz > 0 ? "a".code + mz % 26 : ' '.code);
        sb.addChar( mz > 0 ? "a".code + mz % 26 : ' '.code);
        x += stepX;
      }
      trace(sb.toString());
      y += stepY;
    }
    //for (y = -1.0, stepY = 2.0 / h; y <= 1.0; y += stepY) {
      //sb = "";
      //for (x = -2.0, stepX = 3.0 / w; x <= 1.0; x += stepX) {
        //mz = mandelzahl(x, y, max);
        //sb += mz > 0 ? '-' : '*';
      //}
     //trace(sb);
    //}
  }

  static public function main():Void {

#if sys
    var args = Sys.args(); //$type(Sys.args());
#else
    var args = ["140", "50", "100000"];
#end
    var w = args[0], h=args[1], max =args[2];
    //for (arg in Sys.args())
      //Sys.println(arg);

    mandel(Std.parseInt(w),Std.parseInt(h),Std.parseInt(max));
  }
}
