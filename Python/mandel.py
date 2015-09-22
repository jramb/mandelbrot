import cmath, time

# def mandelzahl(a, max):
#         "parameter is a complex number and max"
#         i = 0
#         r = a
#         while i<max and (r.real*r.real + r.imag*r.imag)<4:
#                 r = r*r + a
#                 i = i+1
#         if i==max:
#                 i=-1
#         return i

def mandelzahl(cx,cy, max):
        "parameters are a complex number and max"
        zx=cx
        zy=cy
        i=1
        while i<max and ( (zx*zx) + (zy*zy) ) < 4.0:
            x2=zx*zx
            y2=zy*zy
            zy = zx*zy*2 + cy
            zx = x2 - y2 + cx
            i=i+1
        if i==max:
           i=-1
        return i

def mandel(w=140,h=50,max=100):
        stepY = 2.0 / h
        stepX = 3.0 / w
        for y in range(h):
                line = ''
                for x in range(w):
                        # z = mandelzahl(-2+x*stepX + (-1+y*stepY)*1j, max)
                        z = mandelzahl(-2+x*stepX, -1+y*stepY, max)
                        if z>=0:
                                line = line + chr(ord('a')+(z % 26))
                        else:
                                line = line + ' '
                print(line)


# alt: use perf_time() (uses
startPr=time.process_time()
startPe=time.perf_counter()
mandel(140,50,1e4)
print("Time: %.3fs (%.3fs)" % ((time.process_time()-startPr), (time.perf_counter()-startPe)))
# print(mandelzahl(0+0j, 100))
# print(mandelzahl(0.5+0.5j, 100))
