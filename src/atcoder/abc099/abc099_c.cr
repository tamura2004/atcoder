# メモ化再帰
require "crystal/memo"

class Problem < Memo(Int64, Int64)
  def g(money)
    ret = money
    [6, 9].each do |unit|
      (1..7).each do |k|
        break if money < unit ** k
        chmin ret, f(money - unit ** k) + 1
      end
    end
    ret
  end
end
      
n = gets.to_s.to_i
ans = Problem[n]
pp ans
