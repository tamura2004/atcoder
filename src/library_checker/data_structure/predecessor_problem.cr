require "crystal/orderedset"

n, q = gets.to_s.split.map(&.to_i64)
t = gets.to_s.chars.map(&.to_i)
st = (0_i64...n).select { |i| t[i] == 1 }.to_ordered_set

q.times do
  cmd, k = gets.to_s.split.map(&.to_i64)
  case cmd
  when 0
    st << k
  when 1
    st >> k
  when 2
    puts st.includes?(k) ? 1 : 0
  when 3
    puts st.upper(k, eq: true) || -1
  when 4
    puts st.lower(k, eq: true) || -1
  end
end