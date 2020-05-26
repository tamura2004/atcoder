# PAST 001 L グラデーション
# 方針
# 大きい塔（全部）と小さい塔（一部）を合わせて
# プリム法で最小全域木を求める。
# 小さい塔（5本）についてはbit全探索

class UnionFind
  def initialize(n); @data = Array.new(n,-1); end
  def find(a); @data[a] < 0 ? a : @data[a] = find(@data[a]); end
  def same?(a,b); find(a) == find(b); end
  def size(a); -@data[find(a)]; end
  def unite(a,b)
    a = find(a); b = find(b)
    return if a == b
    a,b = b,a if @data[a] > @data[b]
    @data[a] += @data[b]; @data[b] = a
  end
end

# UnionFind.new(N) := 要素数Nで初期化
# Ai := i番目の要素
# find(i) := Aiが属するグループ
# same?(i,j) := Ai,Ajが同じグループに属する
# size(i) := Aiが属するグループの要素の数
# unite(i,j) := Ai,Ajを同じグループに統合する

# クラスカル法
def kruskal(n,edges)
  edges.sort!
  uf = UnionFind.new(n)
  edges.inject(0.0) do |ans,(cost,a,b)|
    break ans if uf.size(a) >= n
    next ans if uf.same?(a,b)
    uf.unite(a,b)
    ans += cost
  end
end

# 題意に沿った辺の作成
def make_edge(towers,i,j)
  xi,yi,ci = towers[i]
  xj,yj,cj = towers[j]
  cost = (xi - xj) ** 2 + (yi - yj) ** 2
  cost = Math.sqrt(cost.to_f)
  cost *= 10 if ci != cj
  [cost, i, j]
end

# 補助
def iota(n,offset=0); n.times.map{|i|i+offset}; end
class Array
  def mask(bit)
    select.with_index do |_, i|
      bit >> i & 1 == 1
    end
  end
end

n,m = gets.split.map(&:to_i)
towers = Array.new(n+m){ gets.split.map(&:to_i) }

# 小さな塔の付与パターンをbit全探索で網羅
ans = 10**12
(1<<m).times do |bit|
  ix = iota(n) + iota(m,n).mask(bit)
  
  edges = []
  ix.product(ix).each do |i,j|
    next unless i < j
    edges << make_edge(towers,i,j)
  end
  ret = kruskal(n+m,edges)
  ans = ret if ans > ret
end

puts ans
