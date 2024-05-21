# ゲーム探索
require "crystal/game_search"

n = gets.to_s.to_i64
ab = Array.new(n) do |i|
  a, b = gets.to_s.split.map(&.to_i64)
  {a, b, i}
end

gs = GameSearch(Int32).new do |s|
  res = Set(Int32).new

  sub = ab.select { |abi| s.bit(abi[2]) == 1 }
  suba = sub.group_by(&.[0]).values
  subb = sub.group_by(&.[1]).values
  
  suba.each do |arr|
    next if arr.size < 2
    arr.each_combination(2) do |(c1, c2)|
      i1 = c1[2]
      i2 = c2[2]
      t = s ^ (1 << i1) ^ (1 << i2)
      res << t
    end
  end
  
  subb.each do |arr|
    next if arr.size < 2
    arr.each_combination(2) do |(c1, c2)|
      i1 = c1[2]
      i2 = c2[2]
      t = s ^ (1 << i1) ^ (1 << i2)
      res << t
    end
  end

  res.to_a
end

root = (1 << n) - 1
ans = gs.solve(root)
puts ans.win? ? :Takahashi : :Aoki
