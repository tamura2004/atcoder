1000.times do
  x = rand(1..1000)
  a = rand(1..1000)
  d = rand(1..1000)

  left = (x + a * d) // d
  right = x // d + a

  if left != right
    pp! [x,a,d,left,right]
  end
end
