-- Mandel, 2016-06-01++ by JRamb

local width = tonumber(arg and arg[1]) or 140
local height = tonumber(arg and arg[2]) or 50
local maxd = tonumber(arg and arg[3]) or 100000 -- Chicken! :)

local function mandelzahl(cx, cy, max)
  local zx, zy, x2, y2 = 0, 0, 0, 0
  local i = 0
  repeat
    zy, zx = zx * zy * 2 + cy , x2 - y2 + cx
    x2, y2 = zx * zx, zy * zy
    i = i+1
  until i >= max or x2 + y2 >= 4
  return i<max and i or -1
end

local function mandel(w,h,max)   --{{{
    local x, y
    for  y = -1.0, 1.0, 2.0 / h do
      local line = {}
      for x = -2.0, 1.0,  3.0 / w do
        local mz = mandelzahl(x, y, max)
        --table.insert(line, mz<0 and ' ' or char(string.byte('a') + (mz % 26)))
        line[#line+1] = mz<0 and ' ' or string.char(string.byte('a') + (mz % 26))
      end
      print(table.concat(line))
    end
end

mandel(width,height,maxd)

