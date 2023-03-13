# 原始ピタゴラス数をすべて列挙する
#
# ```
# it = PrimePythagoreanTripleIterator.new
# it.first(3).to_a # [[3, 4, 5], [5, 12, 13], [8, 15, 17]]
# ```
class PrimePythagoreanTripleIterator
  include Iterator(Array(Int64))
  getter n : Int64
  getter m : Int64

  def initialize
    @n = 2
    @m = 1
  end

  def next
    begin
      a = n ** 2 - m ** 2
      b = n * m * 2
      c = n ** 2 + m ** 2
      [a,b,c].sort
    ensure
      while true
        @m += 1
        if n == m
          @n += 1
          @m = 1
        end
        break if (n ^ m).odd? && n.gcd(m) == 1
      end
    end
  end
end
