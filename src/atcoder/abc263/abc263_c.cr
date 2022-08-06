n, m = gets.to_s.split.map(&.to_i64)

q = Deque(Array(Int32)).new
(1..m).each do |i|
  q << [i]
end

while q.size > 0
  a = q.shift

  if a.size == n
    puts a.join(" ")
  else
    next if a[-1] == m
    (a[-1]+1..m).each do |v|
      q << a + [v]
    end
  end
end
