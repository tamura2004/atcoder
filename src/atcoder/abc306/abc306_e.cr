require "crystal/st"
require "crystal/cc"
require "crystal/range"

n, k, q = gets.to_s.split.map(&.to_i64)
queries = Array.new(q) do
  x, y = gets.to_s.split.map(&.to_i64)
  x -= 1
  {x, y}
end

keys = [0_i64] + queries.map(&.last.-)
cc = CC.new(keys)

a = Array.new(n, 0_i64)
cnt = cc.size.to_st_sum
sum = cc.size.to_st_sum
cnt[cc[0]] = n

queries.each do |x, y|
  pre = a[x]
  a[x] = y

  cnt[cc[-pre]] -= 1
  cnt[cc[-y]] += 1
  sum[cc[-pre]] -= pre
  sum[cc[-y]] += y

  j = (0..cc.size).bsearch do |i|
    k <= cnt[..i]
  end.not_nil!

  # pp! a
  # pp! cnt
  # pp! j
  # pp! cnt[j..]
  # pp! sum[j..]
  # pp! sum[j]

  jj = cnt[..j] - k

  ans = sum[..j] - sum[j] // cnt[j] * jj
  pp ans
end
