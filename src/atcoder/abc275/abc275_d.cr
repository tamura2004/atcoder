require "crystal/memo"

n = gets.to_s.to_i64
ans = Problem[n]
pp ans

class Problem < Memo(Int64, Int64)
  def g(n)
    return 1_i64 if n.zero?
    f(n // 2) + f(n // 3)
  end
end
