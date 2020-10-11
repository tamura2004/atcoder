class UnionFindTree
  getter n : Int32
  getter a : Array(Int32)

  def initialize(@n)
    @a = Array.new(n, -1)
  end

  def find(i)
    a[i] < 0 ? i : (a[i] = find(a[i]))
  end

  def same?(i, j)
    find(i) == find(j)
  end

  def size(i)
    -a[find(i)]
  end

  def unite(i, j)
    i = find(i)
    j = find(j)
    return if i == j
    i, j = j, i if a[i] > a[j]
    a[i] += a[j]
    a[j] = i
  end
end

n = gets.to_s.to_i
s = gets.to_s.chomp
t = gets.to_s.chomp

uf = UnionFindTree.new(200)

n.times do |i|
  si, ti = s[i], t[i]
  next if si == ti
  next if is_num?(si) && is_num?(ti)

  ti = '@' if is_num?(ti)
  si = '@' if is_num?(si)
  uf.unite(si.ord, ti.ord)
end

ans = 1_i64
n.times do |i|
  si = s[i]
  next if is_num?(si)
  next if uf.same?(si.ord, '@'.ord)

  if i == 0
    ans *= 9
  else
    ans *= 10
  end
  uf.unite(si.ord, '@'.ord)
end

pp ans

def is_num?(c : Char)
  ('0'..'9').includes?(c)
end

def is_alp?(c : Char)
  ('a'..'z').includes?(c)
end
