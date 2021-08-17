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

  def initialize(a, digit = 10)
    @a = a.map(&.to_i)
    @digit = digit.to_i
    @n = @a.size
  end

  # 通常
  def each
    n.times do |i|
      [EDGE, FREE].each do |k|
        digit.times do |d|
          next if k == EDGE && a[i] < d
          kk = k == EDGE && d == a[i] ? EDGE : FREE

          yield i, k, d, kk
        end
      end
    end
  end

  # 先頭がゼロフラグ付き
  def each_with_leading_zero
    n.times do |i|
      [ZERO, NONZ].each do |j|
        [EDGE, FREE].each do |k|
          digit.times do |d|
            next if k == EDGE && a[i] < d
            jj = j == ZERO && d == 0 ? ZERO : NONZ
            kk = k == EDGE && d == a[i] ? EDGE : FREE

            yield i, j, k, d, jj, kk
          end
        end
      end
    end
  end
end
