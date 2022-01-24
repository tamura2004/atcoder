# 未満フラグ
EDGE = 0
FREE = 1

# 先頭ゼロフラグ
ZERO = 0
NONZ = 1

# 桁DPのイテレータ
#
# 数字丁度=EDGE、以後自由=FREE
class DigitDP
  getter n : Int32
  getter a : Array(Int32)
  getter digit : Int32 # k進数

  def initialize(a : Array(Int32), digit = 10)
    @a = a.map(&.to_i)
    @digit = digit.to_i
    @n = @a.size
  end

  def initialize(s : String)
    a = s.chars.map(&.to_i)
    initialize(a)
  end

  # 通常
  def each
    n.times do |i|
      [EDGE, FREE].each do |k|
        next if i.zero? && k == FREE
        digit.times do |d|
          next if k == EDGE && a[i] < d
          kk = k == EDGE && d == a[i] ? EDGE : FREE
          yield i, k, d, kk, a[i]
        end
      end
    end
  end
end

alias DD = DigitDP