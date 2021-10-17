local function mandelzahl(cr, ci, max, i, tr, ti, tr2, ti2)
  if (i >= max) then
    return -1
  elseif ((tr2 + ti2) >= 4) then
    return i
  else
    local tr0, ti0 = ((tr2 - ti2) + cr), ((tr * ti * 2) + ci)
    return mandelzahl(cr, ci, max, (i + 1), tr0, ti0, (tr0 * tr0), (ti0 * ti0))
  end
end
local function mandel(w, h, max)
  for y = -1.0, 1.0, (2.0 / h) do
    local line = {}
    for x = -2.0, 1.0, (3.0 / w) do
      local mz = mandelzahl(x, y, max, 0, 0, 0, 0, 0)
      do end (line)[(#line + 1)] = (((mz < 0) and " ") or string.char((string.byte("a") + (mz % 26))))
    end
    print(table.concat(line))
  end
  return nil
end
local function arg_def(nr, default)
  return (tonumber((arg and arg[nr])) or default)
end
local width = arg_def(1, 140)
local height = arg_def(2, 50)
local max = arg_def(3, 100000.0)
return mandel(width, height, max)
