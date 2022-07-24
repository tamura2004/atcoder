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

class Graph
  attr_reader :n, :g, :ind

  def initialize(n)
    @n = n
    @g = Array.new(n) { [] }
    @ind = Array.new(n, 0)
  end

  def add(v, nv)
    g[v] << nv
    ind[nv] += 1
  end

  def [](v)
    g[v]
  end

  def tsort
    ans = []
    q = []

    n.times do |v|
      q << v if ind[v].zero?
    end

    while q.size > 0
      v = q.shift
      ans << v

      g[v].each do |nv|
        ind[nv] -= 1
        q << nv if ind[nv].zero?
      end
    end
    ans
  end
end

s = gets.chomp
t = gets.chomp
n = s.size
m = t.size

g = Graph.new(n)

if n < m
  s = s * ((m + n - 1) / n)
end

cnt = ZAlgorithm.new(t + "@" + s + s).solve

n.times do |v|
  i = v + m + 1
  if cnt[i] == m
    nv = (v + m) % n
    g.add v, nv
  end
end

dp = Array.new(n, 0)
ts = g.tsort

if ts.size < n
  pp -1
  exit
end

ts.each do |v|
  g[v].each do |nv|
    dp[nv] = dp[v] + 1
  end
end

pp dp.max
