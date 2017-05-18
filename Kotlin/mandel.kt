// 2017 by J.Ramb while learning Kotlin (it's a thing now)

private fun depth(cx:Double, cy:Double, max:Int):Int {
  var zx:Double = 0.0
  var zy:Double = 0.0
  var i = -1
  var x2:Double = 0.0
  var y2:Double = 0.0
  while (++i <= max && x2 + y2 < 4)
  {
    zy = zx * zy * 2.0 + cy
    zx = x2 - y2 + cx
    x2 = zx * zx
    y2 = zy * zy
  }
  return i
}

private fun depth2Char(d:Int):Char {
  return ('a'.toInt() + d % 26).toChar()
}

private fun mandelbrot(w:Int = 140, h:Int = 70, max:Int = 100000) {
  var x:Double
  var y:Double
  var stepX = 3.0 / w
  var stepY = 2.0 / h
  y = 1.0
  while (y >= -1.0)
  {
    x = -2.0
    while (x < 1.0)
    {
      val d = depth(x, y, max)
      print(if (d > max) ' ' else depth2Char(d))
      x += stepX
    }
    println()
    y -= stepY
  }
}

fun main(args:Array<String>) {
  val w = args[0]?.toInt()
  val h = args[1]?.toInt()
  val max = args[2]?.toInt()
  mandelbrot(w, h, max)
  println("$w x $h, max = $max")
}
