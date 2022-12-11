require "crystal/multiset"

n, m, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
st = Multiset(Int64).new
ans = [] of Int64

n.times do |i|
  st << a[i]

  if m <= i
    st.delete(a[i - m])
  end

  if m <= st.size
    tail = st ^ k
    ans << (st.root.try &.acc || 0_i64)
    st + tail
  end
end

puts ans.join(" ")
