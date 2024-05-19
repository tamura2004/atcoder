n = gets.to_s.to_i64
ac = Array.new(n) do |i|
  a, c = gets.to_s.split.map(&.to_i64)
  { a, c, i.to_i64 }
end.sort.reverse

ans = [] of Tuple(Int64,Int64,Int64)
ac.each do |a, c, i|
  if ans.empty?
    ans << { a, c, i }
  elsif ans[-1][1] >= c
    ans << { a, c, i }
  end
end

pp ans.size
puts ans.map(&.last.succ).sort.join(" ")