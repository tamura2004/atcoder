# 文字列アルゴリズム
class String
  macro get_rank(i)
    rank[{{i}}]? || -1
  end

  macro cost(i, k)
    { get_rank({{i}}), get_rank({{i}}+{{k}}) }
  end

  # 接尾辞配列*sa*と順位*rank*を返す
  def suffix_array : Tuple(Array(Int32), Array(Int32))
    rank = (0..size).map { |i| i == size ? -1 : self[i].ord - 'a'.ord }

    tmp = [-1] * (size + 1)
    sa = (0..size).map(&.itself)

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

    return {sa, rank}
  end

  # 接尾辞配列を用いた文字列検索
  def sa_contain
    sa, rank = suffix_array
    ->(t : String) do
      lo = 0
      hi = size

      while hi - lo > 1
        mid = (lo + hi) // 2
        if self[sa[mid], t.size] < t
          lo = mid
        else
          hi = mid
        end
      end

      self[sa[hi], t.size] == t
    end
  end

  # 高さ配列*lcp*を求める
  def lcp
    sa, rank = suffix_array

    h = 0
    lcp = [0] * (size + 1)

    size.times do |i|
      j = sa[rank[i] - 1]
      h -= 1 if h > 0

      while j + h < size && i + h < size
        break if self[j + h] != self[i + h]
        h += 1
      end

      lcp[rank[i] - 1] = h
    end

    return {sa, rank, lcp}
  end
end
