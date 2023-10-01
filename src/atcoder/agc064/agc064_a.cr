n = gets.to_s.to_i
ans = [] of Int32
(1..n - 2).each do |i|
  ans << i
end
ans << n
ans << n - 1

n.step(by: -2, to: 2) do |i|
  if i == 2
    ans << i
  else
    (i - 2).times do
      ans << i
      ans << i - 1
    end
    ans << i
  end
end
puts ans.join(" ")
