s = gets.to_s
st = [] of Char
cnt = Array.new(26,0)
s.chars.each do |c|
  case c
  when '('
    st << c
  when ')'
    while st[-1] != '('
      ch = st.pop
      cnt[ch.ord - 'a'.ord] -= 1
    end
    st.pop
  else
    if cnt[c.ord - 'a'.ord] > 0
      quit "No"
    else
      cnt[c.ord - 'a'.ord] += 1
      st << c
    end
  end
end

puts "Yes"