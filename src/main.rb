x = 1
y = 1

10.times do
  x = x + y

  pp [x, y]

  y = x + y

  pp [x, y]
end
