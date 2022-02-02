require "crystal/segment_tree"

record T, v : Int64 do
  LIMIT = 2_000_000_i64

  def +(b : self)
    T.new(v <= Int64::MAX - b.v ? Math.min(LIMIT, v + b.v) : LIMIT)
  end

  def self.zero
    T.new(0)
  end

  delegate to_i64, to_s, inspect, to: v
end

a = "abab".chars.map(&.ord.- 'a'.ord)
n = a.size

right = make_array(-1, n, 2)
left = make_array(-1, n, 2)

cnt = make_array(-1, 2)
(0...n).to_a.reverse.each do |i|
  2.times do |j|
    cnt[j] = i if a[i] == j
    right[i][j] = cnt[j]
  end
end

cnt = make_array(-1, 2)
n.times do |i|
  2.times do |j|
    cnt[j] = i if a[i] == j
    left[i][j] = cnt[j]
  end
end

pp right
pp left

values = Array.new(5) { T.zero }
st = SegmentTree(T).range_sum_query(values)
st[4] = T.new(1)
3.downto(0) do |i|
  lo = i + 1
  hi = 4
  if lo < 4 && right[lo][a[i]] != -1
    hi = right[lo][a[i]]
  end
  hi = 4 if hi == -1
  st[i] = st[lo..hi]
end

st.debug

3.downto(1) do |i|
  j = left[i-1][a[i]]
  if j != -1
    st[j] += st[i]
  end
end

st.debug




# st[0] = T.new Int64::MAX
# st[1] = T.new Int64::MAX

# pp st[0..]

# ans = [] of String

# (1<<4).times do |s|
#   cnt = [] of Char
#   4.times do |i|
#     cnt << a[i] if s.bit(i) == 1
#   end
#   ans << cnt.join
# end

# pp ans.sort.uniq.zip(0..)

# [{"", 0},
#  {"a", 1},
#  {"aa", 2},
#  {"aab", 3},
#  {"ab", 4},
#  {"aba", 5},
#  {"abab", 6},
#  {"abb", 7},
#  {"b", 8},
#  {"ba", 9},
#  {"bab", 10},
#  {"bb", 11}]