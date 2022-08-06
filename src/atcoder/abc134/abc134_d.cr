n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)

b = Array.new(n, 0)

(1..n).reverse_each do |i|
  cnt = 0
  (i+i).step(by: i, to: n) do |j|
    cnt ^= b[j-1]
  end

  b[i-1] = a[i-1] ^ cnt
end

c = b.zip(1..).select(&.first.== 1).map(&.last)
puts c.size
puts c.join(" ")