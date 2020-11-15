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

  def gsize
    n.times.map { |i| find(i) }.uniq.size
  end
end

n, q = gets.to_s.split.map { |v| v.to_i }
c = gets.to_s.split.map { |v| v.to_i - 1 }

uf = UnionFindTree.new(n.to_i)
cnt = Array.new(n) { Hash(Int32, Int32).new { |h, k| h[k] = 0 } }
n.times do |i|
  cnt[i][c[i]] = 1
end

q.times do
  cmd, a, b = gets.to_s.split.map { |v| v.to_i - 1 }
  case cmd
  when 0
    next if uf.same?(a, b)
    i, j = uf.find(a), uf.find(b)
    uf.unite(a, b)
    k = uf.find(a)
    case
    when i == k
      cnt[j].each do |key, value|
        cnt[i][key] += value
      end
    when j == k
      cnt[i].each do |key, value|
        cnt[j][key] += value
      end
    end
  when 1
    puts cnt[uf.find(a)][b]
  end
end
