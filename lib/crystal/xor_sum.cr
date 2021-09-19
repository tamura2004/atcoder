require "crystal/mod_int"

# 数列Aiについて、Σ Ai xor Ajをmodで求める
# ただし Ai <= 2 ** 60
# ```
# a = [0,1,2]
# 0^1 + 1^2 + 0^2 = 1 + 3 + 2 = 6
# XORSum.new(a).sum # => 6
# ```
struct XORSum
  DIGIT = 60
  getter a : Array(Int64)

  def initialize(a)
    @a = a.map(&.to_i64)
  end

  def solve
    DIGIT.times.reduce(0.to_m) do |acc, i|
      ii = DIGIT - 1 - i
      cnt = Array.new(2, 0_i64.to_m)
      a.each do |v|
        cnt[v.bit(ii)] += 1
      end
      acc * 2 + cnt[0] * cnt[1]
    end
  end
end
