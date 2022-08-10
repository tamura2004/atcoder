def chmin(a, b)
  p = pointerof(a)
  if a > b
    p.value = b
  end
end

a = 100
b = 50
chmin(a,b)
pp a
