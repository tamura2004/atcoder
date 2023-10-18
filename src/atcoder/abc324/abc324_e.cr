require "crystal/st"

# sに（連続するとは限らない）部分文字列として含まれるtのprefixの最大の長さ
def solve(s, t)
  j = 0_i64
  s.chars.each do |c|
    if j < t.size && t[j] == c
      j += 1
    end
  end
  return j
end

N = 500_000_i64

n, t = gets.to_s.split
n = n.to_i

rt = t.reverse
len = t.size

pre = Array.new(N+1, 0_i64).to_st_sum
suf = Array.new(N+1, 0_i64).to_st_sum

n.times do |i|
  s = gets.to_s
  k1 = solve(s, t) 
  pre[k1] += 1
  k2 = solve(s.reverse, rt)
  suf[k2] += 1
end

ans = (0_i64..N).sum do |i|
  pre[i] * suf[(Math.max 0_i64, len - i)..]
end

pp ans
