# 半分全列挙サンプル
class SplitAndList
  getter n : Int32
  getter s : Array(Char)
  getter lo : Array(Char)
  getter hi : Array(Char)

  def self.read
    n = gets.to_s.to_i
    s = gets.to_s.chars
    new(n, s)
  end

  def initialize(@n, @s)
    @lo = s.first(n)
    @hi = s.last(n).reverse
  end

  def solve
    lo_cnt = collect_split_pattern(lo)
    hi_cnt = collect_split_pattern(hi)

    # pp! lo
    # pp! hi
    # pp! lo_cnt
    # pp! hi_cnt

    lo_cnt.sum do |k,v|
      v * hi_cnt[k]
    end
  end

  # 塗分けパターンを集計
  def collect_split_pattern(a)
    cnt = Hash(Tuple(String, String), Int64).new { |h, k| h[k] = 0_i64 }
    n = a.size
    (1<<n).times do |mask|
      key = split_by_mask(a, mask)
      cnt[key] += 1
    end
    return cnt
  end

  # 配列aをビットマスクで分割
  def split_by_mask(a, mask)
    n = a.size
    b = [] of Char
    c = [] of Char
    n.times do |i|
      if mask.bit(i) == 1
        b << a[i]
      else
        c << a[i]
      end
    end
    return {b.join, c.join}
  end
end

pp SplitAndList.read.solve
