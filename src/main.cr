require "crystal/range_set"

n, m = gets.to_s.split.map(&.to_i)
st = RangeSet.new

m.times do
  lo, hi = gets.to_s.split.map(&.to_i64)
  st << (lo...hi)
end

# ans = st.size
# pp ans
pp st