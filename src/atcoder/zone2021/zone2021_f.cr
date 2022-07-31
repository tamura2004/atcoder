require "crystal/xor_base"

n, m  = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i)
b = (1...n).to_a - a

x = XorBase.new
b.each do |v|
  x << v
end

nn = Math.ilogb(n)

quit -1 if x.raw.size < nn

v = 0
n.times do |s|
  next if s.zero?
  s = s ^ (s >> 1)
  nv = 0
  nn.times do |i|
    next if s.bit(i).zero?
    nv ^= x.raw[i]
  end
  # pp [s.to_s(2), v, nv]
  puts "#{v} #{nv}"
  v = nv
end


