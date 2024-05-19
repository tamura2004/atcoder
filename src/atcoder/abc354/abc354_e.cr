# 初期状態から、残りカードの状態をbitとして遷移グラフを作る
# その後、TsortしてDP

require "crystal/graph"
require "crystal/graph/tsort"

n = gets.to_s.to_i64
ab = Array.new(n) do |i|
  a, b = gets.to_s.split.map(&.to_i64)
  {a, b, i}
end

memo = Hash(Int32, Bool).new
dfs = uninitialized Proc(Int32, Bool)
dfs = -> (s : Int32) do
  if memo.has_key?(s)
    return memo[s]
  end
  
  res = false # 負け
  
  sub = ab.select { |abi| s.bit(abi[2]) == 1 }
  suba = sub.group_by(&.[0]).values
  subb = sub.group_by(&.[1]).values
  
  suba.each do |arr|
    next if arr.size < 2
    arr.each_combination(2) do |(c1, c2)|
      i1 = c1[2]
      i2 = c2[2]
      t = s ^ (1 << i1) ^ (1 << i2)
      res ||= !dfs.call(t)
    end
  end
  
  subb.each do |arr|
    next if arr.size < 2
    arr.each_combination(2) do |(c1, c2)|
      i1 = c1[2]
      i2 = c2[2]
      t = s ^ (1 << i1) ^ (1 << i2)
      res ||= !dfs.call(t)
    end
  end
  
  memo[s] = res
  res
end

ans = dfs.call((1 << n) - 1)
puts ans ? :Takahashi : :Aoki
