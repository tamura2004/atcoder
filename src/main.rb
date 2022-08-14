cnt = [
  [13, 4],
  [17, 5],
  [19, 7],
]

10000.times do |i|
  flag = cnt.all? do |m, r|
    (i % m) == r
  end

  if flag
    pp i
  end
end

pp 1603 % 13
pp 1603 % 17
pp 1603 % 19
