# 未満フラグ
EDGE = 0
FREE = 1

# 先頭ゼロフラグ
ZERO = 0
NONZ = 1

# 多次元配列マクロ
macro make_array(value, *dims)
  {% for dim in dims %} Array.new({{dim}}) { {% end %}
    {{ value }}
  {% for dim in dims %} } {% end %}
end

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
    leading_zero = true
    n.times do |i|
      [EDGE, FREE].each do |k|
        next if k == FREE && leading_zero
        digit.times do |d|
          next if k == EDGE && a[i] < d
          kk = k == EDGE && d == a[i] ? EDGE : FREE
          yield i, k, d, kk, leading_zero, a[i]
        end
      end
      leading_zero = false if a[i] != 0
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
