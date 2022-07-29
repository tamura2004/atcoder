# Manacharアルゴリズム
#
# i番目の要素を中心とする最長の回文の半径
module Indexable(T)
  def manacher
    n = size
    ans = Array.new(n, 1)
    i = j = 0
    while i < n
      while i - j >= 0 && i + j < n && self[i-j] == self[i+j]
        j += 1
      end

      ans[i] = j
      k = 1

      while i - k >= 0 && k + ans[i - k] < j
        ans[i+k] = ans[i-k]
        k += 1
      end

      i += k
      j -= k
    end
    ans
  end
end

class String
  def manacher
    chars.manacher
  end
end
