class SuffixArray
  attr_accessor :n, :s, :ans

  def initialize(s)
    @s = s
    @n = s.size
    @rank = (n + 1).times.map { |i| i == n ? -1 : s[i].ord - "a".ord }
    @ans = (n + 1).times.map(&:itself)
  end

  def rank(i)
    i > n ? -1 : @rank[i]
  end

  def cond(i, k)
    [rank(i), rank(i + k)]
  end

  def solve
    tmp = []
    k = 1
    while k <= n
      ans.sort_by! do |i|
        cond(i, k)
      end

      tmp[ans[0]] = 0
      1.upto(n) do |i|
        tmp[ans[i]] = tmp[ans[i - 1]] + (cond(i - 1, k) == cond(i, k) ? 0 : 1)
      end
      (n + 1).times { |i| @rank[i] = tmp[i] }

      pp @ans
      puts

      k *= 2
    end
  end
end

sa = SuffixArray.new("abdabc")
sa.solve
pp sa.ans
