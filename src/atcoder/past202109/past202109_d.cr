require "crystal/prime"
x, y = gets.to_s.split.map(&.to_i64)
puts %w(Z X Y)[x.factors.size <=> y.factors.size]
