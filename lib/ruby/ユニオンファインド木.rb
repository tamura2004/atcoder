class UnionFind
  def initialize(n); @data = Array.new(n, -1); end
  def find(a); @data[a] < 0 ? a : @data[a] = find(@data[a]); end
  def same?(a, b); find(a) == find(b); end
  def size(a); -@data[find(a)]; end

  def unite(a, b)
    a = find(a); b = find(b)
    return if a == b
    a, b = b, a if @data[a] > @data[b]
    @data[a] += @data[b]; @data[b] = a
  end
end

# UnionFind.new(N) := 要素数Nで初期化
# Ai := i番目の要素
# find(i) := Aiが属するグループ
# same?(i,j) := Ai,Ajが同じグループに属する
# size(i) := Aiが属するグループの要素の数
# unite(i,j) := Ai,Ajを同じグループに統合する

uf = UnionFind.new(10)
pp uf.same(1, 2)
