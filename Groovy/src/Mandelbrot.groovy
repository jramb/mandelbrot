#!/usr/bin/env groovy
// 2014, hacked together with NO good knowledge of Groovy, really
// 2015, slightly improved after reading little about Groovy

import groovy.transform.CompileStatic
import groovy.transform.TypeChecked


@CompileStatic
int depth(double cx, double cy, int max) {
    double x2, y2
    double zx = cx
    double zy = cy
    int i = -1
    while (++i <= max && (x2 = zx * zx) + (y2 = zy * zy) < 4.0d) {
      zy = zx * zy * 2.0d + cy
      zx = x2 - y2 + cx
    }
    return i
}

//assert 4 == depth(0.5, 0.5, 100)

char depth2Char(int d) { ('a'..'z')[d%26] }
//char depth2Char(d) { 'x' }

/*
 *def ranger(start, end, steps) {
 *  def s = (end-start) / steps
 *    (0..steps-1).collect { start + it*s }
 *}
 */

def time(body) {
  def start = System.currentTimeMillis()
  body();
  println "Time taken: ${(System.currentTimeMillis() - start)/1000} s"
}

void mandel(int w = 140, int h = 50, int max = 1000) {
  double stepY = 2.0d / h, stepX = 3.0d / w
  //(-1).step(1, 2.0 / h) { y ->
  for (double y = -1.0d ; y <= 1.0d ; y += stepY) {
    def sb = "" // new StringWriter()
    //(-2).step(1,3.0 / w) { x ->
    for(double x=-2.0d ; x<= 1.0d ; x+= stepX) {
        int d = depth x,y,max
        sb += (d > max ? ' ' : depth2Char(d))
      }
    println sb
  } 
}

time { 
  if (args.size()>=3) {
    //(w,h,max) = args.collect(Integer.&parseInt)
    //(w,h,max) = args*.asType(int)
    mandel args*.asType(int)
  } else {
    mandel ()
  }
}
println args

