s = gets.to_s.chars
st = [] of Char

s.each do |c|
  if st.size >= 2 && st[-2] == 'A' && st[-1] == 'B' && c == 'C'
    st.pop(2)
  else
    st << c
  end
end

puts st.join
