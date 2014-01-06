/*
Mandelbrot in LiveScript
2014 by JRamb
*/

print||=console.log

mandelzahl=(cx, cy, max) ->
  #// z -> z^2 + c
  zx=zy=0.0
  i=0
  while ++i<=max and (zx*zx+zy*zy)<4
    #slower [zx, zy] = [zx*zx - zy*zy + cx, zx*zy*2 + cy]
    tx = zx*zx - zy*zy + cx
    zy = zx*zy*2 + cy
    zx = tx
  if i>max then -1 else i

mandel = (w, h, max) ->
  for y from -1.0 to 1.0 by 2.0/h
    sb = ""
    for x from -2.0 to 1.0 by 3.0/w
      mz = mandelzahl(x,y,max)
      if mz>0
        sb = sb + '-'
      else
        sb = sb + '*'
    print sb

mandel 140, 50, 1e5

null
