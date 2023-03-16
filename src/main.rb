a = [3, 2, 1, 6, 5, 4]
b = [0]

a.each do |v|
  b << b[-1] + v
end
pp b
