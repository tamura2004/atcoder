# サイコロを振ってK以上なら勝ち
# k / 2 以上なら、1/2で勝ち
# k / 4 以上なら、1/4で勝ち

# xが出たときの勝つ確率
def solve(x, k)
  return 1.0 if k <= x
  0.5 * solve(x<<1, k)
end

n, k = gets.to_s.split.map(&.to_i64)

ans = 0.0
(1..n).each do |i|
  ans += solve(i, k)
end
ans /= n
pp ans
