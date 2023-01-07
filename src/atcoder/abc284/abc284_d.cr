require "crystal/prime"
require "crystal/math"

pr = [] of Int32
Prime.each do |p|
  pr << p
end

t = gets.to_s.to_i64
t.times do
  n = gets.to_s.to_i64
  pr.each do |p|
    if n % p == 0
      n //= p
      if n % p == 0
        q = n // p
        puts "#{p} #{q}"
      else
        q = Math.isqrt(n)
        puts "#{q} #{p}"
      end
      break
    end        
  end
end

