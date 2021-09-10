require "crystal/mod_int"

# kitamasa法
def poww(a, n)
  return a if n == 1
  return poww(prod(a, a), n//2) if n % 2 == 0
  prod(a, poww(a, n - 1))
end

def prod(a, b)
  k = a.size
  c = [0.to_m] * (k * 2 - 1)

  k.times do |i|
    k.times do |j|
      c[i + j] += a[i] * b[j]
    end
  end

  (k...k*2 - 1).reverse_each do |i|
    k.times do |j|
      c[i - k + j] += c[i]
    end
  end

  c[...k]
end

k, n = gets.to_s.split.map(&.to_i64)
a = [0.to_m, 1.to_m] + [0.to_m] * (k - 2)
ans = poww(a, n - 1).sum
pp ans
