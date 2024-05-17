require "crystal/range_chmin_range_sum"

n = gets.to_s.to_i64
s = gets.to_s.split.sort

def suffix(s, t)
  n = Math.min s.size, t.size
  ans = 0_i64
  n.times do |i|
    if s[i] != t[i]
      return ans
    end
    ans += 1
  end
  ans
end

lcp = [0_i64] + (1...n).map do |i|
  suffix(s[i - 1], s[i])
end

ans = 0_i64

values = Array.new(n, 1e6.to_i64)
st = values.to_range_chmin_range_sum

n.times do |i|
  l = lcp[i]
  st[..i] = l
  ans += st[..i]
end

pp ans
