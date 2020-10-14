n,m = gets.to_s.split.map { |v| v.to_i64 }
num = Array.new(n, 1)
red = Array.new(n,0)
red[0] = 1

m.times do
  x,y = gets.to_s.split.map { |v| v.to_i64 - 1}
  if num[x] == 1
    if red[x] == 1
      red[x] = 0
      red[y] = 1
      num[x] -= 1
      num[y] += 1
    else
      num[x] -= 1
      num[y] += 1
    end
  else
    if red[x] == 1
      red[y] = 1
      num[x] -= 1
      num[y] += 1
    else
      num[x] -= 1
      num[y] += 1
    end
  end
end

puts red.count(&.== 1)