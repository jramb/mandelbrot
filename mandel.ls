# Mandelbrot in LiveScript
/* 2014 by JRamb */

if typeof Packages=="object" # running in Rhino?
  print = -> java.lang.System.out.println it
else
  print||=console.log

mandelzahl=(cx, cy, max) ->
  #// z -> z^2 + c
  zx=zy=0.0
  i=0
  while ++i<=max and ( (x2=zx*zx) + (y2=zy*zy) )<4
    zy = zx*zy*2 + cy
    zx = x2 - y2 + cx

  ## The following is not really slower!
  #while ++i<=max and (zx*zx+zy*zy)<4
  #  #THIS is slower: [zx, zy] = [zx*zx - zy*zy + cx, zx*zy*2 + cy]
  #  tx = zx*zx - zy*zy + cx
  #  zy = zx*zy*2 + cy
  #  zx = tx

  if i>max then -1 else i

#a + ib * c + id
#ac-bd , (a+b)(c+d)-ac-bd.
#zx * zx - zy*zy + cx, (zx+zy)*(zx+zy) - zx*zx - zy*zy + cy

mandel = (w, h, max) !->
  for y from -1.0 to 1.0 by 2.0/h
    sb = ""
    for x from -2.0 to 1.0 by 3.0/w
      mz = mandelzahl(x,y,max)
      sb += if mz>0 then \- else \*
    print sb

mandel 140, 50, 1e5

