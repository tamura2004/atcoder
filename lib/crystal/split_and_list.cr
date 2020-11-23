# 半分全列挙サンプル
class SplitAndList
  getter n : Int32
  getter x : Int64
  getter a : Array(Int64)
  getter m : Int32
  getter lo : Array(Int64)
  getter hi : Array(Int64)
  getter lo_cnt : Hash(Int64, Int32)
  getter hi_cnt : Hash(Int64, Int32)
  getter lo_sum : Array(Int64)
  getter hi_sum : Array(Int64)

  def self.read
    n, x = gets.to_s.split.map { |v| v.to_i64 }
    a = Array.new(n) { gets.to_s.to_i64 }
    new(n.to_i, x, a)
  end

  def initialize(@n, @x, @a)
    @m = n // 2
    @lo = a.first(m)
    @hi = a.last(n - m)
    @lo_sum = all_combinarion_sum(@lo)
    @hi_sum = all_combinarion_sum(@hi)
    @lo_cnt = @lo_sum.tally
    @hi_cnt = @hi_sum.tally
    @lo_sum.uniq!.sort!
    @hi_sum.uniq!.sort!.reverse!
  end

  def solve
    lo_sum.sum do |lo|
      hi_num = hi_sum.bsearch do |hi|
        x >= lo + hi
      end
      if hi_num && lo + hi_num == x
        lo_cnt[lo] * hi_cnt[hi_num]
      else
        0
      end
    end
  end

  # ビットに応じた要素の合計
  private def all_combinarion_sum(a)
    n = a.size
    (1 << n).times.map do |mask|
      n.times.sum do |i|
        mask.bit(i) == 1 ? a[i] : 0_i64
      end
    end.to_a
  end

  # 配列aをビットマスクで分割
  def split_by_mask(a, mask)
    n = a.size
    b = [] of Int32
    c = [] of Int32
    n.times do |i|
      if mask.bit(i) == 1
        b << a[i]
      else
        c << a[i]
      end
    end
    return {b, c}
  end
end

pp SplitAndList.read.solve
