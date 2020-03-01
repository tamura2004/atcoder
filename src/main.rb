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

# UnionFind木で連結成分の要素数を求める
# 友人、ブロックの隣接リスト作成
# 人別(N),友人数(M)で二重ループしながらUF参照
# Mが疎なので計算量はO(M)、ブロックについてもO(K)

n,m,k = gets.split.map &:to_i
UF = UnionFind.new(n)
FR = Array.new(n){[]}
BL = Array.new(n){[]}

m.times do
  a,b = gets.split.map &:to_i
  a -= 1; b -= 1
  UF.unite(a,b)
  FR[a] << b
  FR[b] << a
end

k.times do
  a,b = gets.split.map &:to_i
  a -= 1; b -= 1
  BL[a] << b
  BL[b] << a
end

ans = n.times.map do |i|
  cnt = UF.size(i)
  FR[i].each do |f|
    cnt -= 1 if UF.same?(i,f)
  end
  BL[i].each do |b|
    cnt -= 1 if UF.same?(i,b)
  end
  cnt -= 1
end

puts ans.join(" ")