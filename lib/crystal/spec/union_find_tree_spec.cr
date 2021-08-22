require "spec"
require "../union_find_tree"

macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

describe UnionFindTree do
  it "usage" do
    s = UnionFindTree.new(6)
    s.size(0).should eq 1
    s.size(3).should eq 1
    s.size(5).should eq 1
    s.same?(0, 3).should eq false

    s.unite(0, 5)
    s.unite(3, 5)

    s.size(0).should eq 3
    s.size(3).should eq 3
    s.size(5).should eq 3
    s.same?(0, 3).should eq true
  end

  it "weight" do
    uf = UnionFindTree.new(10)
    uf.unite 0, 1, 5
    uf.unite 2, 3, 4
    uf.unite 1, 2, 3
    uf.diff(0, 3).should eq 12
  end

  it "count num of path of connected partial graph" do
    a = [{1, 1}, {1, 2}, {2, 2}, {3, 3}]
    uf = UnionFindTree.new(4)
    a.each do |i, j|
      uf.unite(i, j)
    end
    uf.size(1).should eq 2
  end

  it "solve acl practice A" do
    query = [
      {1, 0, 1},
      {0, 0, 1},
      {0, 2, 3},
      {1, 0, 1},
      {1, 1, 2},
      {0, 0, 2},
      {1, 1, 3},
    ]
    ACLPracticeA.new(4, 7, query).solve.should eq [0, 1, 0, 1]
  end

  it "solve JOI2007HO B case 1" do
    n = 7
    k = 5
    a = [1, 3, 4, 6, 7]
    JOI2007HO_B.new(n, k, a).solve.should eq 2
  end

  it "solve JOI2007HO B case 2" do
    n = 7
    k = 5
    a = [0, 3, 4, 6, 7]
    JOI2007HO_B.new(n, k, a).solve.should eq 5
  end

  it "solve ARC027B" do
    ARC027B.new(6, "PRBLMB", "ARC027").solve.should eq 90
  end
end

# https://atcoder.jp/contests/practice2/tasks/practice2_a
alias Query = Tuple(Int32, Int32, Int32)

class ACLPracticeA
  getter n : Int32
  getter q : Int32
  getter query : Array(Query)

  def initialize(@n, @q, @query)
  end

  def solve
    ans = [] of Int32
    set = UnionFindTree.new(n)
    query.each do |(t, u, v)|
      case t
      when 0
        set.unite(u, v)
      when 1
        ans << (set.same?(u, v) ? 1 : 0)
      end
    end
    ans
  end
end

# https://atcoder.jp/contests/joi2007ho/tasks/joi2007ho_b
class JOI2007HO_B
  getter n : Int32
  getter k : Int32
  getter a : Array(Int32)

  def initialize(@n, @k, @a)
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

# https://atcoder.jp/contests/arc027/tasks/arc027_2
class ARC027B
  getter n : Int32
  getter s : String
  getter t : String

  def initialize(@n, @s, @t)
  end

  def solve
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

    return ans
  end

  private def is_num?(c : Char)
    ('0'..'9').includes?(c)
  end

  private def is_alp?(c : Char)
    ('a'..'z').includes?(c)
  end
end
