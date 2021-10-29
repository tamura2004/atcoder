require "crystal/mod_int"

t = gets.to_s.to_i
t.times do
  n,k = gets.to_s.split.map(&.to_i64)
  pp solve(n,k)
end

def solve(n,k)
  ans = 0.to_m
  0.upto(k) do |i|
    ans += n.c(i)
  end
  ans
end