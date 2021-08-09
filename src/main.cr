require "crystal/prime"

macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

n = gets.to_s.to_i
a, b = (1..n).map { gets.to_s.split.map(&.to_i) }.transpose

ans = 0_i64

Prime.factors(a[0]).each do |x|
  Prime.factors(b[0]).each do |y|
    flag = true    
    a[1...n].each do |a|
      b[1..n].each do |b|
        next if a % x == 0 && b % y == 0
        next if b % x == 0 && a % y == 0

        flag = false
        break
      end
    end
    next unless flag

    chmax ans, x.to_i64.lcm(y.to_i64)
  end
end

pp ans