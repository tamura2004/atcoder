# 乱択で強引に
n = gets.to_s.to_i
items = Array.new(n) do
  a,b,c = gets.to_s.split.map(&.to_f64)
  {a,b,c}
end

asum = items.map(&.first).sum
bsum = items.map(&.[1]).sum

ans = 0.0
600.times do
  sa = sb = sc = 0.0
  n.times do |i|
    r = rand
    next if rand < 0.5
    sa += items[i][0]
    sb += items[i][1]
    sc += items[i][2]
  end

  chmax ans, sc / Math.max(sa,sb)
end

pp ans
