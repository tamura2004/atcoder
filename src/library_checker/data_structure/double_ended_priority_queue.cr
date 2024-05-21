require "crystal/multiset"

n, q = gets.to_s.split.map(&.to_i64)
s = gets.to_s.split.map(&.to_i64)
st = s.to_multiset

q.times do
  cmd, x = gets.to_s.split.map(&.to_i64) + [0_i64]
  case cmd
  when 0
    st << x
  when 1
    pp st.shift
  when 2
    pp st.pop
  end
end
