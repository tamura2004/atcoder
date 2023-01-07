require "crystal/string/z_algorithm"

n = gets.to_s.to_i
t = gets.to_s.chars

za = (t[0...n] + ['@'] + t[n...n*2].reverse).join.z_algorithm
i = za[n..].max
s = t.first(i) + t.last(n - i)

quit -1 if i.zero?
quit -1 if s != t[i...i+n].reverse
puts s.join
puts i