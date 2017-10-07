//package mandel
// 2017 by J.Ramb while learning Kotlin (it's a thing now)

private fun depth(cx: Double, cy: Double, max: Int): Int {
    var zx = 0.0
    var zy = 0.0
    var i = -1
    var x2 = 0.0
    var y2 = 0.0
    while (++i <= max && x2 + y2 < 4) {
        zy = zx * zy * 2.0 + cy
        zx = x2 - y2 + cx
        x2 = zx * zx
        y2 = zy * zy
    }
    return i
}

private fun depth2Char(d: Int): Char {
    return ('a'.toInt() + d % 26).toChar()
}

private fun mandelbrot(w: Int = 140, h: Int = 70, max: Int = 100000) {
    val stepX = 3.0 / w
    val stepY = 2.0 / h

    // use pmap for parallel execution, map for sequential here:
    (0 until h).pmap {
        val y = 1.0 - it * stepY
        val b:String =
        (0 until w).map {
            val x = -2.0 + it * stepX
            val d = depth(x, y, max)
            if (d > max) ' ' else depth2Char(d) // return of the lambda
        }.joinToString(separator="")
        //Pair(it, b) // to make it sortable for the pmap version, which returns the lines in any order
        it to b // Same as Pair(it, b), just showing off!
    }.sortedBy {it.first}.forEach { println(it.second) }
}

fun main(args: Array<String>) {
    val w = args.elementAtOrNull(0)?.toInt() ?: 140
    val h = args.elementAtOrNull(1)?.toInt() ?: 50
    val max = args.elementAtOrNull(2)?.toInt() ?: 100_000
    mandelbrot(w, h, max)
    println("$w x $h, max = $max")
}
