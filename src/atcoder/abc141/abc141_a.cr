require "crystal/indexable"

# 正解できなかった場合、K - Qがポイント
# x回正解した場合、K - Q + Xがポイント
# 正解した回数をtallyで集計して、ポイントごとに表示する

n, k, q = gets.to_s.split.map(&.to_i64)
a = Array.new(q) { gets.to_s.to_i.pred }.tally

po = Array.new(n, k - q)
a.each do |i, x|
  po[i] += x
end

n.times do |i|
  puts po[i] <= 0 ? "No" : "Yes"
end
