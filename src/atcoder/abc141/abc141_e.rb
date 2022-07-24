# Z algorithm
# sとs[i..]の共通接頭辞の長さの配列をO(|s|)で求める
#
# ```
# ZAlgorithm.new("abcbcba").solve # => [7,0,0,0,0,0,1]
# ```
class ZAlgorithm
  attr_reader :n, :s, :ans

  def initialize(s)
    @s = s
    @n = s.size
    @ans = Array.new(n, 0)
    ans[0] = n
  end

  def solve
    i = 1
    j = 0

    while i < n
      while i + j < n && s[j] == s[i + j]
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

n = gets.to_i
s = gets.chomp

ans = 0
n.times do |i|
  z = ZAlgorithm.new(s[i..]).solve
  cnt = z.zip(0..).map { |a, b| a < b ? a : b }.max
  ans = cnt if ans < cnt
end

pp ans
