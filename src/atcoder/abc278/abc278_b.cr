def to_i(a,b,c,d)
  (a * 10 + b) * 60 + c * 10 + d
end

def to_time(i)
  i = i % (24 * 60)
  ab, cd = i.divmod(60)
  c, d = sprintf("%02d",cd).chars.map(&.to_i)
  a, b = sprintf("%02d",ab).chars.map(&.to_i)
  {a,b,c,d}
end

h, m = gets.to_s.split.map(&.to_i)
i = h * 60 + m

(24*60).times do
  a,b,c,d = to_time(i)

  ac = a * 10 + c
  bd = b * 10 + d
  if ac < 24 && bd < 60 
    printf("%d%d %d%d\n",a,b,c,d)
    exit
  end
  i += 1
end
