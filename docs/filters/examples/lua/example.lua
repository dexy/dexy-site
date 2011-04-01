-- http://www.ntecs.de/old-hp/uu9r/lang/html/lua.en.html
function fac(n)
  if n < 2 then
    return 1
  else
    return n * fac(n-1)
  end
end

print(fac(6))

