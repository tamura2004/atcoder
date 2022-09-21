require "crystal/indexable"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
b = gets.to_s.split.map(&.to_i)

ans = 0
29.times do |k|
  t = 2 ** k
  mask = t * 2
  _a = a.map(&.% mask)
  _b = b.map(&.% mask).sort

  cnt = _a.sum do |v|
    lo = t - v
    hi = t * 2 - v

    ({0, t*2}).sum do |d|
      _b.count_range(lo + d...hi + d)
    end
  end
  ans |= (1 << k) if cnt.odd?
end

pp ans
