require "crystal/fft"

N = 1_000_000
s = Array.new(N){rand(0..1)}
t = Array.new(N//2){rand(0..1)}

conv(s,t)