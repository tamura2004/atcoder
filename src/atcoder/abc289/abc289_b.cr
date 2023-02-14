n, m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i).to_set

acc = [] of Int32
ans = [] of Int32
(1..n).each do |i|
  acc << i
  if !i.in?(a)
    ans += acc.reverse
    acc = [] of Int32
  end
end

puts ans.join(" ")
