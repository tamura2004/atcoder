require "crystal/st"

n, m, p = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort
b = gets.to_s.split.map(&.to_i64).sort
# n = 200000i64
# m = 200000i64
# p = 100000000i64
# a = Array.new(n) { rand(100000000i64) }
# b = Array.new(m) { rand(100000000i64) }
st = b.to_st_sum

ans = a.sum do |v|
  cnt = b.bsearch_index { |u| p - v <= u } || m

  case cnt
  when m
    m * v + st[0..]
  when 0
    p * m
  else
    v * cnt + st[...cnt] + p * (m - cnt)
  end
end

pp ans
