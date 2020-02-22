MOD = 10 ** 9 + 7

class ModCombination
  attr_reader :fac, :inv, :finv, :mod
 
  def initialize(n, mod: MOD)
    @mod = mod
    @fac = [1, 1]
    @inv = [1, 1]
    @finv = [1, 1]
 
    (2..n).each do |i|
      @fac[i] = fac[i - 1] * i % mod
      @inv[i] = mod - inv[mod % i] * (mod / i) % mod
      @finv[i] = finv[i - 1] * inv[i] % mod
    end
  end
 
  def combination(n, k)
    return 0 if n < k
    return 0 if n < 0 || k < 0
 
    fac[n] * (finv[k] * finv[n - k] % mod) % mod
  end
  
  def repeated_combination(n, k)
    combination(n + k - 1, k)
  end
end
 
mc = ModCombination.new(10000)

N = gets.to_i
T = N.times.map { gets.to_i }
T.sort!

H = Hash.new(0)
T.each do |t|
  H[t] += 1
end

now = 0
pena = 0
N.times do |i|
  now += T[i]
  pena += now
end

pat = 1
H.each_pair do |k,v|
  pat *= mc.fac[v]
  pat %= MOD
end

puts pena
puts pat
