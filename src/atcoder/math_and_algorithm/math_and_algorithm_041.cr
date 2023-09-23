require "crystal/imos"

t = gets.to_s.to_i
st = IMOS(Int64).new(t)
n = gets.to_s.to_i64
n.times do
  l, r = gets.to_s.split.map(&.to_i)
  st[l...r] = 1_i64
end
st.update!

t.times do |i|
  pp st[i]
end
