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

n, m = gets.to_s.split.map { |v| v.to_i }
a = gets.to_s.split.map { |v| v.to_i }
b = gets.to_s.split.map { |v| v.to_i }
uf = UnionFind.new(n)
m.times do
  c, d = gets.to_s.split.map { |v| v.to_i - 1 }
  uf.unite(c, d)
end

c = Array.new(n, 0)
n.times do |i|
  j = uf.find(i)
  c[j] += b[i] - a[i]
end

ans = c.all?(&:zero?)
puts ans ? "Yes" : "No"
