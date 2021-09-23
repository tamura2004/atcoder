cnt = 0
100000.times do
  a = Array.new(99, rand).sort
  cnt = a[29]
end

pp cnt / 1000
