require "../lib/crystal/ntt_convolution"
require "colorize"

include Random::Secure

MOD = 998244353
N = 100

10.times do
  a = Array.new(N) { rand(0..MOD - 1).to_i64 }
  b = Array.new(N) { rand(0..MOD - 1).to_i64 }
  c = a.dup
  d = b.dup
  g = a.dup
  h = b.dup
  e = convolution(a, b, MOD)
  f = convolution_mini(c, d, MOD)
  if e != f
    pp! g
    pp! h
    pp! e
    pp! f
    puts "result mismatch".colorize(:red)
    exit
  end
end

puts "success".colorize(:green)
