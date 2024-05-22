# Sliding Window Aggregation
#
# 加算に関するモノイドをなす型Tに対して、SWAGを構築する。
# sum() a0 + a1 + a2 ... + an-1を計算する
# <<(x) xを末尾に追加する
# shift() a0を削除する
# unshift() a0を追加する
# self.zero 単位元
# ```
# swag = SWAG(Int32).new
# swag << 10
# swag << 20
# swag << 30
# swag.sum # => 60
# swag.pop
# swag.sum # => 50
class SWAG(T)
  getter left : Array(Tuple(T, T))
  getter right : Array(Tuple(T, T))

  def initialize
    @left = [] of Tuple(T, T)
    @right = [] of Tuple(T, T)
  end

  def sum
    if left.empty? && right.empty?
      T.zero
    elsif left.empty?
      right.last[1]
    elsif right.empty?
      left.last[1]
    else
      left.last[1] + right.last[1]
    end
  end

  def push(x : T)
    if right.empty?
      right << { x, x }
    else
      right << { x, right.last[1] + x }
    end
  end

  def <<(x : T)
    push(x)
  end

  def unshift(x : T)
    if left.empty?
      left << { x, x }
    else
      left << { x, x + left.last[1] }
    end
  end

  def shift
    if left.empty?
      n = right.size
      a = right.map(&.first)
      right.clear
      (0...n//2).reverse_each do |i|
        unshift(a[i])
      end
      (n//2...n).each do |i|
        push(a[i])
      end
    end
    if !left.empty?
      left.pop
    end
  end

  def pop
    if right.empty?
      n = left.size
      a = left.map(&.first)
      left.clear
      (0...n//2).reverse_each do |i|
        push(a[i])
      end
      (n//2...n).each do |i|
        unshift(a[i])
      end
    end
    if !right.empty?
      right.pop
    end
  end
end
