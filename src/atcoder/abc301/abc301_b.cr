n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
ans = [a[0]]

(1...n).each do |i|
  if ans[-1] < a[i]
    if ans[-1] + 1 < a[i]
      (ans[-1].succ...a[i]).each do |j|
        ans << j
      end
    end
    ans << a[i]
  else
    if ans[-1].pred > a[i]
      ans[-1].pred.downto(a[i].succ) do |j|
        ans << j
      end
    end
    ans << a[i]
  end
end

puts ans.join(" ")
