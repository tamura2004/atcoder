require "crystal/dynamic_mod_int"

struct Problem
  getter mod : Int64
  getter a : Array(Int32)
  getter mint : DynamicModInt

  def initialize
    @mod = gets.to_s.to_i64
    @a = gets.to_s.split.map(&.to_i)
    @mint = DynamicModInt.new(mod)
  end

  def polypow(a, k)
  end
  
  def solve
    n = mod - 1
    ans = Array.new(mod, 0_i64)
    mod.times do |i|
      if a[i] == 1
        # (x - i) ^ n
        # == Σk=0..n, c(n,k) * x^k * (-i) * (n - k)
        (0..n).each do |k|
          cnt = mint.c(n, k)
          cnt *= mint.pow(-i, n - k)
          cnt %= mod
          ans[k] -= cnt
          ans[k] %= mod
        end
        ans[0] += 1
        ans[0] %= mod
      end
    end
    puts ans.join(" ")
  end
end

Problem.new.solve
