require "crystal/int"
require "crystal/memo"

n = gets.to_s.to_i64
puts Main[n]

class Main < Memo(Int64, Int64)
  COINS = [6, 9].map(&.to_i64)
  ONE = 1_i64

  def g(k : K)
    return 0_i64 if k.zero?
    COINS.each.min_of do |coin|
      ONE.step_pow(to: k, by: coin).min_of do |v|
        f(k - v) + 1
      end
    end
  end
end
