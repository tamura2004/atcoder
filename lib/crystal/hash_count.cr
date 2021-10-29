# 個数を管理するハッシュ
class HashCount(K)
  getter h : Hash(K,Int64)
  getter size : Int64
  delegate "[]", to: h

  def initialize
    @h = Hash(K,Int64).new(0_i64)
    @size = 0_i64
  end

  def <<(k)
    @size += 1 if h[k].zero?
    h[k] += 1
  end

  def delete(k)
    h[k] -= 1
    @size -= 1 if h[k].zero?
  end
end
