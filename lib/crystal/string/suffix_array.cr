# 接尾辞配列
#
# s = "abcba"
# suffix_array = すべての接尾辞を昇順に並べたものまたはそのインデックス
# 0, 5, ""
# 1, 4, "a"
# 2, 0, "abcba"
# 3, 3, "ba"
# 4, 1, "bcbaa"
# 5, 2, "cba"
# sa = [5,4,0,3,1,2]
# rank = [2,4,5,3,1,0]
# lcp = [0,1,0,1,0,0]
#
class SuffixArray
  getter a : Array(Int64)
  getter sa : Array(Int64)   # 接尾辞配列
  getter rank : Array(Int64) # 順位
  getter lcp : Array(Int64)  # 最長共通接頭辞の長さ
  delegate size, to: a

  def initialize(s : String)
    @a = s.chars.map(&.ord.to_i64)
    initialize(@a)
  end

  def initialize(@a : Array(Int64))
    @rank = Array.new(size.succ) do |i|
      i == size ? -1_i64 : a[i]
    end
    @sa = Array.new(size.succ, &.itself.to_i64)
    @lcp = Array.new(size.succ, 0_i64)
  end

  def solve
    tmp = Array.new(size.succ, -1_i64)

    k = 1_i64
    while k <= size
      sa.sort_by! do |i|
        cost(i, k)
      end

      tmp[sa[0]] = 0_i64

      1.upto(size) do |i|
        tmp[sa[i]] = tmp[sa[i - 1]] + (cost(sa[i - 1], k) < cost(sa[i], k)).to_unsafe
      end

      (size + 1).times { |i| rank[i] = tmp[i] }
      k *= 2
    end

    h = 0_i64
    lcp = [0_i64] * (1_i64 + size)

    size.times do |i|
      j = sa[rank[i] - 1]
      h -= 1 if h > 0

      while j + h < size && i + h < size
        break if a[j + h] != a[i + h]
        h += 1
      end

      lcp[rank[i] - 1] = h
    end

    {sa, rank, lcp}
  end

  # 接尾辞配列を用いた検索
  def includes?(t)
    lo = 0
    hi = size

    while hi - lo > 1
      mid = (lo + hi) // 2
      if a[sa[mid], t.size] < t
        lo = mid
      else
        hi = mid
      end
    end

    a[sa[hi], t.size] == t
  end

  # 接尾辞配列マクロ
  def get_rank(i)
    rank[i]? || -1
  end

  # 接尾辞配列マクロ
  def cost(i, k)
    { get_rank(i), get_rank(i+k) }
  end
end

class String
  def to_suffix_array
    SuffixArray.new(self).solve
  end
end
