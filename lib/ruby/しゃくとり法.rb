# lo,hi,cnt,ans = 0,0,1,0
# while hi < n
#   # 右を進める
#   cnt *= a[hi]
#   hi += 1
 
#   # 条件を満たすまで左を追いつく
#   while k < cnt
#     cnt /= a[lo]
#     lo += 1
#   end
 
#   # 条件を満たしている
#   len = hi - lo
#   ans = len if ans < len
# end
class Syakutori
  attr_reader :a, :n, :k, :lo, :hi, :cnt, :ans
  def initialize(n,k,a)
    @a = a
    @n = n
    @k = k
    @lo = 0
    @hi = 0
    @cnt = 1
    @ans = 0
    yield self
  end

  def move_hi!
    @cnt *= a[hi]
    @hi += 1
  end
  
  def move_lo!
    @cnt /= a[lo]
    @lo += 1
  end
  
  def update!
    len = hi - lo
    @ans = len if ans < len
  end

  def valid?
    cnt <= k
  end

  # 右固定
  def solve
    return n if a.any?(&:zero?)
    return 0 if k.zero?

    while hi < n
      move_hi!
      move_lo! until valid?
      update!
    end
    return @ans
  end

  # 左固定
  def solve_lo
    while lo < n
      move_hi while valid?
      update
      move_lo
    end
    return @ans
  end

end

n,k = gets.to_s.split.map{ |v| v.to_i }
a = Array.new(n){ gets.to_s.to_i }

Syakutori.new(n,k,a) do |s|
  s.solve!
  puts s.ans
end