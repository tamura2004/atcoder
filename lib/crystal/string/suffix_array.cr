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
  getter a : Array(Int32)
  getter sa : Array(Int32)   # 接尾辞配列
  getter rank : Array(Int32) # 順位
  getter lcp : Array(Int32)  # 最長共通接頭辞の長さ
  delegate size, to: a

  def initialize(s : String)
    @a = s.chars.map(&.ord)
    initialize(@a)
  end

  def initialize(@a : Array(Int32))
    @rank = Array.new(size.succ) do |i|
      i == size ? -1 : a[i]
    end
    @sa = Array.new(size.succ, &.itself)
    @lcp = Array.new(size.succ, 0)
  end

  def solve
    tmp = Array.new(size.succ, -1)

    k = 1
    while k <= size
      sa.sort_by! do |i|
        cost(i, k)
      end

      tmp[sa[0]] = 0

      1.upto(size) do |i|
        tmp[sa[i]] = tmp[sa[i - 1]] + (cost(sa[i - 1], k) < cost(sa[i], k)).to_unsafe
      end

      (size + 1).times { |i| rank[i] = tmp[i] }
      k *= 2
    end

    h = 0
    lcp = [0] * (size + 1)

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
