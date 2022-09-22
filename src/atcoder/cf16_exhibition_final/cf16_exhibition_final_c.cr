n = gets.to_s.to_i
a = Array.new(n) { gets.to_s.to_i }
b = a.map { |v| Math.ilogb(v & -v) }.tally
c = a.map { |v| v ^ (v - 1) }
tot = a.reduce { |a, b| a ^ b }

# pp tot.to_s(2)

ans = 0
(0..29).reverse_each do |k|
  if tot.bit(k) == 1 && b.has_key?(k)
    v = 1 << k
    tot ^= v ^ (v - 1)
    ans += 1
  end
end

puts tot == 0 ? ans : -1
