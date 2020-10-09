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

macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

n, k = gets.to_s.split.map { |v| v.to_i }
a = Array.new(k) { gets.to_s.to_i }.sort

pp JOI2007HO_B.new(n,k,a).solve

class JOI2007HO_B
  getter n : Int32
  getter k : Int32
  getter a : Array(Int32)

  def initialize(@n,@k,@a)
  end

  def solve
    return 1 if n == 1 || k == 1

    wild = false
    if a[0] == 0
      a.shift
      wild = true
    end

    uf = UnionFindTree.new(n + 1)
    a.each_cons(2) do |(x, y)|
      if x + 1 == y
        uf.unite(x, y)
      end
    end

    ans = 1.upto(n).max_of do |i|
      uf.size(i)
    end

    if wild
      ans += 1
      1.upto(n - 2) do |i|
        unless uf.same?(i, i + 2)
          chmax ans, uf.size(i) + uf.size(i + 2) + 1
        end
      end
    end

    return ans
  end
end