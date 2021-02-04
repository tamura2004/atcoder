n = gets.to_s.to_i
a = Array.new(n) do
  b = gets.to_s.chars.map(&.to_i)
  ans = 0
  (n-1).downto(0) do |i|
    if b[i] == 1
      ans = i + 1
      break
    end
  end
  ans
end

ans = 0
n.times do |i|
  i.upto(n-1) do |j|
    if a[j] <= i + 1
      ans += j - i
      j.downto(i+1) do |k|
        a.swap k,k-1
      end
      break
    end
  end
end

puts ans