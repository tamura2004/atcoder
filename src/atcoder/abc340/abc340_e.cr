require "crystal/dual_segment_tree"

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

st = DualSegmentTree(Int64).range_add(n)
n.times do |i|
  st[i] = a[i]
end

m.times do |i|
  j = b[i]
  ball = st[j]
  st[j] = -st[j]
  
  q, r = ball.divmod(n)
  j = (j + 1) % n


  st[0_i64...n] = q

  if j + r < n
    st[j...j+r] = 1_i64
  else
    st[j...n] = 1_i64
    st[0_i64...j+r-n] = 1_i64
  end
end

puts st.to_a.first(n).join(" ")

