k = gets.to_s.to_i64
ans = (1..k).sum do |a|
  (1..k).sum do |b|
    (1..k).sum do |c|
      a.gcd(b.gcd(c))
    end
  end
end
pp ans
