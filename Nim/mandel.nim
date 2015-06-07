import complex
 
var max = 100000
proc mandelbrot(a: Complex): Complex =
  var i = 0
  result = a
  #while i<max and abs(result)<2:
  while i<max and (result.re*result.re+result.im*result.im)<4:
    result = result * result + a
    i = i + 1
 
iterator stepIt(start: float, step: float, iterations: int) =
  for i in 0 .. iterations:
    yield start + float(i) * step
 
var rows = ""
for y in stepIt(-1.0, (2.0/50), 51):
  for x in stepIt(-2.0, (3.0/140), 141):
    if abs(mandelbrot((x,y))) < 2:
      rows.add('*')
    else:
      rows.add(' ')
  echo rows
  rows = ""
 
