Query = Struct.new(:t, :x, :c)
n = gets.to_i
s = gets.chomp.chars
q = gets.to_i
queries = Array.new(q) do
  t, x, c = gets.split
  t = t.to_i
  x = x.to_i - 1
  Query.new(t, x, c)
end.reverse

used = false
filtered = queries.select do |query|
  case
  when query.t == 1
    true
  when used
    false
  else
    used = true
    true
  end
end.reverse

filtered.each do |query|
  case query.t
  when 1
    s[query.x] = query.c
  when 2
    s = s.join.downcase.chars
  when 3
    s = s.join.upcase.chars
  end
end

puts s.join
