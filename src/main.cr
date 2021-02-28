# 寿司iはmod tでai秒目に食べられる
# 今x秒である、次のmod tでa秒まで何秒？
def nex(x, a, t)
  y = x % t
  if y <= a
    a - y
  else
    t + a - y
  end
end

n,t = gets.to_s.split.map { |v| v.to_i }
a = gets.to_s.split.map { |v| v.to_i }
ans = 0_i64
n.times do |i|
  ans += nex(ans, a[i], t)
end

puts ans