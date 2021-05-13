def f(s)
  s.chars.chunks(&.itself).map{|e,a|{e,a.size}}
end

ans = 0
s = gets.to_s
t = f(s)
t.each_cons(3) do |(j,o,i)|
  next if j[0] != 'J'
  next if o[0] != 'O'
  next if i[0] != 'I'

  next if j[1] < o[1]
  next if i[1] < o[1]
  ans = Math.max ans, o[1]
end

pp ans
