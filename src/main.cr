require "crystal/prime"

MAX = 1_000_000

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

cnt = a[0]
a[1..].each do |v|
  cnt = cnt.gcd(v)
end
quit "not coprime" if cnt != 1

siv = Array.new(MAX + 1, false)
a.each do |i|
  quit "setwise coprime" if siv[i]
  i.prime_factors.each do |j|
    j.step(by: j, to: MAX) do |k|
      siv[k] = true
    end
  end
end

puts "pairwise coprime"
