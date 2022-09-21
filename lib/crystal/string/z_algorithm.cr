# Z algorithm
# sとs[i..]の共通接頭辞の長さの配列をO(|s|)で求める
#
# ```
# ZAlgorithm.new("abcbcba").solve # => [7,0,0,0,0,0,1]
# "abcbcba".z_algorithm # => [7,0,0,0,0,0,1]
# [0,1,2,3,2,1,0].z_algorithm # => [7,0,0,0,0,0,1]
# ```
module Indexable(T)
  def z_algorithm
    n = size
    ans = Array.new(n, 0)
    ans[0] = n

    i = 1
    j = 0

    while i < n
      while i + j < n && self[j] == self[i + j]
        j += 1
      end

      ans[i] = j

      if j == 0
        i += 1
        next
      end

      k = 1

      while i + k < n && k + ans[k] < j
        ans[i + k] = ans[k]
        k += 1
      end

      i += k
      j -= k
    end

    ans
  end
end

class String
  def z_algorithm
    chars.z_algorithm
  end
end

class ZAlgorithm
  getter s : String

  def initialize(@s)
  end

  def solve
    s.z_algorithm
  end
end
