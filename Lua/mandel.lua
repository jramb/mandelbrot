-- Mandel, 2016-06-01 by JRamb

local width = tonumber(arg and arg[1]) or 140
local height = tonumber(arg and arg[2]) or 50
local maxd = tonumber(arg and arg[3]) or 10000 -- Chicken! :)
local write, char = io.write, string.char

function mandelzahl(cx, cy, max)
  local zx, zy, i, x2, y2
  zx = cx
  zy = cy
  i = 1
  x2 = zx * zx
  y2 = zy * zy
  while i <= max and x2 + y2 < 4 do
    i = i+1
    x2 = zx * zx
    y2 = zy * zy
    zy = zx * zy * 2 + cy
    zx = x2 - y2 + cx
  end
  if  i > max then
    return -1
  else
    return i
  end
end

function mandel(w,h,max)
    local stepY, sb, x, stepX, x, mz
    for  y = -1.0, 1.0, 2.0 / h do
      local line = {}
      for x = -2.0, 1.0,  3.0 / w do
        mz = mandelzahl(x, y, max)
        if mz<0 then
          table.insert(line, " ")
        else
          table.insert(line, char(string.byte('a') + (mz % 26)))
        end
        --table.insert(line, mz>0 and '-' or '*')
      end
      print(table.concat(line))
    end
end

mandel(width,height,maxd)

