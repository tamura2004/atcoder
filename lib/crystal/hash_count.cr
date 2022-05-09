# 種類数を管理するハッシュ
#
# ```
# hc = HashCount(Int32).new
# hc << 1
# hc << 2
# hc << 1
# hc.size # => 2
# hc.delete 2
# hc.size # => 1
# ```
class HashCount(K)
  getter h : Hash(K,Int64)
  getter size : Int64
  getter hash : UInt64
  delegate "[]", "keys", to: h

  def initialize
    @h = Hash(K,Int64).new(0_i64)
    @size = 0_i64
    @hash = 0_u64
  end

  def <<(k)
    if h[k].zero?
      @size += 1 
      @hash ^= k.hash
    end
    h[k] += 1
  end

  def delete(k)
    h[k] -= 1
    if h[k].zero?
      @size -= 1 
      @hash ^= k.hash
    end
  end
end
