require "crystal/wavelet_matrix"

N = 200000

vs = Array.new(N, 0)
N.times do |i|
  vs[i] = i % 7
end
mt = WaveletMatrix(Int32).new(vs)

7.times do |i|
  pp mt.rank(i, 0...N)
end
