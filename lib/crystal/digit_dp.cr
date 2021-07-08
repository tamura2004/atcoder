EDGE = 0
FREE = 1

ZERO = 0
PLUS = 1

# 桁DPのテンプレート
#
# 数字丁度=EDGE、以後自由=FREE
class DigitDP
  getter n : Int32
  getter a : Array(Int32)

  def initialize(a : String)
    @a = a.chars.map(&.to_i)
    @n = @a.size
  end

  #      /-- big --> X
  # EDGE -- even --> EDGE
  #      \-- small ---> FREE
  # FREE -- all but i != 0 --> FREE
  def each
    n.times do |i|
      [EDGE, FREE].each do |from|
        10.times do |d|
          to = from == EDGE && d == a[i] ? EDGE : FREE
          next if from == EDGE && d > a[i]
          next if from == FREE && to == FREE && i == 0
          yield i, from, to, d
        end
      end
    end
  end

  def each_with_zero
    n.times do |i|
      [EDGE, FREE].each do |from|
        [ZERO,PLUS].each do |zero|
          10.times do |d|
            to = from == EDGE && d == a[i] ? EDGE : FREE
            next if from == EDGE && d > a[i]
            next if from == FREE && to == FREE && i == 0
            yield i, from, to, d, zero
          end
        end
      end
    end
  end
end