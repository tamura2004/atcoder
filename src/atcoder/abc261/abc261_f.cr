require "crystal/balanced_tree/treap/multiset"

def inversion_number(a : Array(U)) forall U
  st = Multiset(U).new
  ans = 0_i64
  a.each do |v|
    st << v
    ans += st.count_upper(v, eq: false)
  end
  ans
end

n = gets.to_s.to_i
c = gets.to_s.split.map(&.to_i.pred)
x = gets.to_s.split.map(&.to_i64)

ans = inversion_number(x)

dp = Array.new(n) { [] of Int64 }
c.zip(x).each do |c, x|
  dp[c] << x
end

n.times do |i|
  next if dp[i].size <= 1
  ans -= inversion_number(dp[i])
end

pp ans
