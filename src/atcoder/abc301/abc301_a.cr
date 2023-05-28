require "crystal/indexable"

n = gets.to_s.to_i64
s = gets.to_s.chars
nn = divceil(n, 2)

t = 0
a = 0

s.each do |c|
  if c == 'T'
    t += 1
    quit "T" if t >= nn
  else
    a += 1
    quit "A" if a >= nn
  end
end
