-- Mandel, 2016-06-01 by JRamb

local width = tonumber(arg and arg[1]) or 140
local height = tonumber(arg and arg[2]) or 50
local maxd = tonumber(arg and arg[3]) or 10000 -- Chicken! :)
local write, char = io.write, string.char

function mandelzahl(cx, cy, max)
  local zx, zy, i, x2, y2
  zx, zy = cx, cy
  i = 1
  x2, y2 = zx * zx, zy * zy
  while i <= max and x2 + y2 < 4 do
    i = i+1
    zy, zx = zx * zy * 2 + cy , x2 - y2 + cx
    x2, y2 = zx * zx, zy * zy
  end
  return i>max and -1 or i
end

function mandel(w,h,max)
    local x, x
    for  y = -1.0, 1.0, 2.0 / h do
      local line = {}
      for x = -2.0, 1.0,  3.0 / w do
        local mz = mandelzahl(x, y, max)
        --write( mz<0 and ' ' or char(string.byte('a') + (mz % 26)))
        table.insert(line, mz<0 and ' ' or char(string.byte('a') + (mz % 26)))
      end
      --print()
      print(table.concat(line))
    end
end

mandel(width,height,maxd)

