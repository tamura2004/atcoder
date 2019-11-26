class UnionFind
  def initialize(n, &block)
    @par = Array.new(n,&:itself)
    @rank = Array.new(n,1)
    instance_eval(&block) if block_given?
  end

  def root(a)
    par = @par[a]
    a == par ? a : @par[a] = root(par)
  end

  def unite(a,b)
    a = root(a); b = root(b)
    return if a == b

    @rank[a] < @rank[b] ? @par[a] = b : @par[b] = a
    @rank[a] += 1 if @rank[a] == @rank[b]
  end

  def same(a,b)
    root(a) == root(b)
  end

  def roots
    @par.map{|a|root(a)}
  end
end

# sample ABC49_D
N,K,L = gets.split.map &:to_i

UnionFind.new(N) do
  K.times do
    a,b = gets.split.map{|v|v.to_i-1}
    unite(a,b)
  end
  UFK = roots
end

UnionFind.new(N) do
  L.times do
    a,b = gets.split.map{|v|v.to_i-1}
    unite(a,b)
  end
  UFL = roots
end

CT = Hash.new(0)
UFK.zip(UFL).each do |e|
  CT[e] += 1
end

puts UFK.zip(UFL).map{|e|CT[e]}.join(" ")