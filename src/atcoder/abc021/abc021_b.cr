# 経路上、同じ町を二回訪れていないならYes

n = gets.to_s.to_i
path = gets.to_s.split.map(&.to_i64)
k = gets.to_s.to_i
path += gets.to_s.split.map(&.to_i64)

ans = path.uniq.size == k + 2
puts ans ? :YES : :NO