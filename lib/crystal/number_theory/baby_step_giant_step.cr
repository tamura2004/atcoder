module NumberTheory
  # あるx,y,mについて x ^ k = y (mod m)となるkを求める
  class BabyStepGiantStep
    def self.solve(x, y, m)
      x = x.to_i64
      y = y.to_i64
      m = m.to_i64

      d = {1_i64 => 0_i64}
      sq = Math.sqrt(m).to_i64 + 1
      z = 1_i64

      sq.times do |i|
        z = (z * x) % m
        next if d.has_key?(z)
        d[z] = i.to_i64 + 1
      end

      if d.has_key?(y)
        return d[y]
      end

      r = modpow(z, m - 2, m)

      1_i64.upto(sq) do |i|
        y = (y * r) % m
        if d.has_key?(y)
          return d[y] + i * sq
        end
      end

      return -1
    end

    def self.modpow(a, b, mod)
      a = a.to_i64
      b = b.to_i64
      mod = mod.to_i64

      ans = 1_i64
      while b > 0
        if b.odd?
          ans *= a
          ans %= mod
        end
        b //= 2
        a *= a
        a %= mod
      end
      ans
    end
  end
end
