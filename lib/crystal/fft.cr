require "complex"

# FFTを使用した畳み込み
#
# ```
# a = [1, 1, 1]
# b = [1, 1, 1]
# conv(a, b) # => [1, 2, 3, 2, 1]
# ```
def conv(a, b)
  m = a.size + b.size - 1
  n = Math.pw2ceil(m)

  z = (0...n).map { |i| zeta(i, n) }

  a = Array.new(n) { |i| i < a.size ? a[i].to_c : 0.to_c }
  b = Array.new(n) { |i| i < b.size ? b[i].to_c : 0.to_c }
  fa = fft(a, z, n)
  fb = fft(b, z, n)
  fab = (0...n).map { |i| fa[i]*fb[i] }
  ifft(fab, z, n).map(&.real.round.to_i64).first(m)
end

# 1のn乗根のi乗
def zeta(i, n)
  phase = Math::PI * 2 * i / n
  Complex.new Math.cos(phase), Math.sin(phase)
end

# 離散フーリエ変換
def fft(a, z, nn)
  n = a.size
  return a if n == 1
  a1 = fft((0...n//2).map { |i| a[i] + a[i + n//2] }, z, nn)
  a2 = fft((0...n//2).map { |i| (a[i] - a[i + n//2]) * z[nn // n * i] }, z, nn)
  (0...n).map { |i| i.even? ? a1[i//2] : a2[i//2] }
end

# 逆変換
#
# ```
# ifft(fft([1, 2, 3])) # => [1,2,3]
# ```
def ifft(a, z, nn)
  fft(a.map(&.conj), z, nn).map(&.conj./(a.size))
end
