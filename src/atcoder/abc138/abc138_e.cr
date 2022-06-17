# 次のsに行くことを繰り上がりと呼ぶことにする
# tを頭から順にみて、繰り上がりの有無と次の場所をO(1)で調べられれば良い
# ix[i][c] := i番目以降で、文字cが出現する次の位置、なければ-1

# require "crystal/balanced_tree/treap/ordered_set"
s = gets.to_s.chars.map(&.ord.- 'a'.ord)
t = gets.to_s.chars.map(&.ord.- 'a'.ord)
n = s.size

# dp = Array.new(26) { OrderedSet(Int32).new }
dp = Array.new(26) { [] of Int32 }
(s + s).each_with_index do |c, i|
  dp[c] << i
end

i = -1
round = 0_i64

t.each do |c|
  # if i = dp[c].upper(i, eq: false)
  if i = dp[c].bsearch(&.> i)
    cr, i = i.divmod(n)
    round += cr
  else
    quit -1
  end
end

ans = round * n + i + 1
pp ans