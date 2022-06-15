# 数列aからXORの基底を取り出す
#
# ```
# a = [0b101, 0b110, 0b011]
# x = XorBase.new
# x << 0b101
# x << 0b110
# x << 0b011
# x.base.should eq [0b101, 0b110]
# ```
class XorBase
  getter base : Array(Int64)
  delegate each, to: base

  def initialize
    @base = [] of Int64
  end

  def initialize(a)
    initialize
    a.each do |v|
      add v
    end
  end

  # vは線形独立か？
  def includes?(v)
    v = v.to_i64
    base.each do |e|
      v = Math.min(v, v ^ e)
    end
    0 < v ? v : nil
  end

  # vが線形独立なら基底に追加
  def add(v)
    if v = includes?(v)
      base << v
    end
  end

  def <<(v)
    add(v)
  end

  # 基底を掃き出し法により標準形へ
  def sweep!
    base.sort!.reverse!
    w = 64
    h = base.size
    row = 0
    (0...w).reverse_each do |i|
      row.upto(h - 1) do |j|
        next if base[j].bit(i) == 0
        base.swap(row, j)
        h.times do |j|
          next if row == j
          base[j] ^= base[row] if base[j].bit(i) == 1
        end
        row += 1
        break
      end
    end
    self
  end

  def debug(w = 64)
    base.each do |x|
      printf("%0#{w}b\n", x)
    end
  end
end
