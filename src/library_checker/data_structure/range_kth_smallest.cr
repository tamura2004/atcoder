require "crystal/compressed_wavelet_matrix"

n, q = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i)
st = CompressedWaveletMatrix(Int32).new(a)

q.times do
  l, r, k = gets.to_s.split.map(&.to_i)
  pp st.kth_smallest(l...r, k)
end
