require "crystal/segment_tree"

# 区間[lo, hi)
# f(x) = a x
# g(x) = b
class Segment(T)
  INF = 2e18.to_i64
  getter lo : T
  getter hi : T
  getter a : T
  getter b : T

  def initialize(@lo, @hi, @a, @b)
  end

  def cross_point
    (b + a - 1) // a
  end

  def max_damage
    mid = cross_point
    if mid <= lo
      a_damage(lo, hi)
    elsif hi <= mid
      b_damage(lo, hi)
    else
      b_damage(lo, mid) + a_damage(mid, hi)
    end
  end

  def max_damage(r)
    mid = cross_point
    if mid <= lo
      a_damage(lo, r)
    elsif r <= mid
      b_damage(lo, r)
    else
      b_damage(lo, mid) + a_damage(mid, r)
    end
  end

  def a_damage(l, r)
    return INF if INF // a <= (l...r).sum
    a * (l...r).sum
  end

  def b_damage(l, r)
    b * (l...r).size
  end

  def find(d)
    (lo..hi).bsearch do |i|
      d <= max_damage(i)
    end
  end
end

n, h = gets.to_s.split.map(&.to_i64)
spells = Array.new(n) do
  t, d = gets.to_s.split.map(&.to_i64)
  {t, d}
end
spells << {0_i64, 0_i64}
spells = spells.sort.reverse.uniq(&.first).reverse
n = spells.size

st_a = spells.map(&.last).to_st_max
st_b = spells.map { |t, d| t*d }.to_st_max

segs = (0...n - 1).map do |i|
  lo = spells[i][0]
  hi = spells[i + 1][0]
  a = st_a[(i + 1)..]
  b = st_b[..i]
  Segment(Int64).new(lo, hi, a, b)
end

# pp segs
# pp segs.map(&.max_damage)

ans = 0_i64
(0...n - 1).each do |i|
  dm = segs[i].max_damage
  if h <= dm
    ans = segs[i].find(h)
    quit ans.try &.-(1)
  else
    h -= dm
    ans = segs[i].hi
  end
  # pp! [ans,h]
end

dm = st_b[0..]
ans += (h + dm - 1) // dm
pp ans.pred
