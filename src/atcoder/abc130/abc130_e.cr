require "crystal/mod_int"
require "crystal/indexable"

n, m = gets.to_s.split.map(&.to_i)
s = gets.to_s.split.map(&.to_i)
t = gets.to_s.split.map(&.to_i)

a = make_array(0.to_m, n + 2, m + 2)
n.succ.times { |i| a[i+1][1] = 1.to_m }
m.succ.times { |j| a[1][j+1] = 1.to_m }

n.times do |i|
  m.times do |j|
    a[i + 2][j + 2] = a[i + 1][j + 2] + a[i + 2][j + 1]
    a[i + 2][j + 2] -= a[i + 1][j + 1] if s[i] != t[j]
  end
end

pp a[-1][-1]
