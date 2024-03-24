n = gets.to_s.to_i
a = Array.new(n * 2, 0)
(1..n).each do |i|
  lo, hi = gets.to_s.split.map(&.to_i.pred)
  lo, hi = hi, lo unless lo < hi
  a[lo] = i
  a[hi] = -i
end

st = [] of Int32
a.each do |v|
  if v > 0
    st << v
  else
    if st[-1] == -v
      st.pop
    else
      quit :Yes
    end
  end
end

puts :No
