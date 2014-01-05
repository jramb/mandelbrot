#
# Mandelbrot in CoffeeScript
#

print=console.log

mandelzahl=(cx, cy, max) ->
  #// z -> z^2 + c
  zx=0.0
  zy=0.0
  i=0
  while(++i<=max and (zx*zx+zy*zy)<4)
    #slower [zx, zy] = [zx*zx - zy*zy + cx, zx*zy*2 + cy]
    tx = zx * zx - zy * zy + cx
    zy = zx * zy * 2 + cy
    zx = tx
  if i>max then -1 else i

mandel = (w, h, max) ->
  y = -1.0
  for y in [-1.0..1.0] by 2.0/h
    sb = ""
    for x in [-2.0..1.0] by 3.0/w
      mz = mandelzahl x,y,max
      if mz>0
        sb = sb + '-'
      else
        sb = sb + '*'
    print sb

mandel 140, 50, 10000
