enum DIR
  R
  L
  U
  D
  RU
  RD
  LU
  LD
end

VECTORS = [
  {1,0},
  {-1,0},
  {0,-1},
  {0,1},
  {1,-1},
  {1,1},
  {-1,-1},
  {-1,1}
]

x, y, s = gets.to_s.split
x = x.to_i.pred
y = y.to_i.pred
s = DIR.parse(s)
v = VECTORS[s.value]
g = Array.new(9){gets.to_s}

4.times do
  print g[y][x]
  x += v[0]
  y += v[1]

  if x < 0
    v = {-v[0],v[1]}
    x = 1
  end
  
  if 9 <= x
    v = {-v[0],v[1]}
    x = 7
  end
  
  if y < 0
    v = {v[0],-v[1]}
    y = 1
  end
  
  if 9 <= y
    v = {v[0],-v[1]}
    y = 7
  end
end

print "\n"