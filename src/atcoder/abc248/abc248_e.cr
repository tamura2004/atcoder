require "crystal/complex"

n, k = gets.to_s.split.map(&.to_i64)
quit "Infinity" if k == 1

z = Array.new(n) do
  C.read
end

ans = n.times.sum do |i|
  (i+1...n).map do |j|
    (z[i] - z[j]).to_r
  end.tally.values.count(k - 1)
end

pp ans
