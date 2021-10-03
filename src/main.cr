require "crystal/modint9"
require "crystal/complex"
require "crystal/segment_tree"

class Compress
  getter a : Array(Int64)
  getter ref : Array(Int64)

  def initialize(@a)
    @ref = a.sort.uniq
  end

  def solve
    -> (v : Int64) do
      ref.bsearch_index do |u|
        v <= u
      end.not_nil!
    end
  end
end

n = gets.to_s.to_i
xy = Array.new(n) do
  C.read
end

f = Compress.new(xy.map(&.real)).solve
g = Compress.new(xy.map(&.imag)).solve

xy = xy.map do |z|
  real = f.call(z.real)
  imag = g.call(z.imag)
  C.new real, imag
end.sort

left = SegmentTree(Int64).range_sum_query(n)
right = SegmentTree(Int64).range_sum_query(n)
dp = make_array(0_i64, n, 4)

n.times do |i|
  z = xy[i]
  y = z.imag.to_i

  dp[i][0] = right[..y]
  dp[i][1] = right[y..]
  right[y] += 1
end

(n-1).downto(0) do |i|
  z = xy[i]
  y = z.imag.to_i

  dp[i][2] = left[..y]
  dp[i][3] = left[y..]
  left[y] += 1
end

ans = 0.to_m
n.times do |i|
  ans += 1
  ans += 2.to_m ** dp[i][0] - 1
  ans += 2.to_m ** dp[i][1] - 1
  ans += 2.to_m ** dp[i][2] - 1
  ans += 2.to_m ** dp[i][3] - 1
  ans += (2.to_m ** dp[i][0] - 1) * (2.to_m ** dp[i][3] - 1) * 2
  ans += (2.to_m ** dp[i][1] - 1) * (2.to_m ** dp[i][2] - 1) * 2
  ans += (2.to_m ** dp[i][0] - 1) * (2.to_m ** dp[i][1] - 1)
  ans += (2.to_m ** dp[i][1] - 1) * (2.to_m ** dp[i][3] - 1)
  ans += (2.to_m ** dp[i][3] - 1) * (2.to_m ** dp[i][2] - 1)
  ans += (2.to_m ** dp[i][2] - 1) * (2.to_m ** dp[i][0] - 1)
  ans += (2.to_m ** dp[i][0] - 1) * (2.to_m ** dp[i][1] - 1) * (2.to_m ** dp[i][3] - 1) * 2
  ans += (2.to_m ** dp[i][2] - 1) * (2.to_m ** dp[i][1] - 1) * (2.to_m ** dp[i][3] - 1) * 2
  ans += (2.to_m ** dp[i][2] - 1) * (2.to_m ** dp[i][0] - 1) * (2.to_m ** dp[i][3] - 1) * 2
  ans += (2.to_m ** dp[i][2] - 1) * (2.to_m ** dp[i][0] - 1) * (2.to_m ** dp[i][1] - 1) * 2
  ans += (2.to_m ** dp[i][0] - 1) * (2.to_m ** dp[i][1] - 1) * (2.to_m ** dp[i][2] - 1) * (2.to_m ** dp[i][3] - 1) * 2
end

pp ans