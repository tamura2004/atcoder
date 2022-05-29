n = gets.to_s.to_i
s = gets.to_s.chars

cnt = s.chunks(&.itself).map{|a,arr|{a,arr.size.to_i64}}
st = [] of Int64

cnt.each_cons(3) do |(s,t,u)|
  if s[0] == 'A' && t[0] == 'R' && u[0] == 'C' && t[1] == 1
    st << Math.min(s[1],u[1])
  end
end

pp Math.min(st.sum, n * 2)