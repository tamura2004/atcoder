# 数列aからXORの基底を取り出す
#
# ```
# a = [0b101,0b110,0b011]
# XorBase.new(a).base.should eq [0b101,0b011]
# ```
class XorBase
  getter base : Array(Int64)

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

  # 基底を掃き出し法により標準形へ
  def sweep!
    w = 64
    h = base.size
    row = 0
    (0...w).reverse_each do |i|
      row.upto(h-1) do |j|
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
end
