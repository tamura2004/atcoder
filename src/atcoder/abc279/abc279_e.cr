n, m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i.pred)

up = (1..n).to_a
dn = (1..n).to_a

a.reverse_each do |i|
  dn.swap i, i+1
end

ix = 0
a.each do |i|
  dn.swap i, i+1

  puts dn[ix]

  up.swap i, i+1

  if up[i] == 1
    ix = i
  end

  if up[i+1] == 1
    ix = i + 1
  end
end


