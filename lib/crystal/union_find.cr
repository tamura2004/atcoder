# 重み付きユニオンファインド木
# 頂点、辺カウントあり
#
# ```
# uf = UnionFind.new(4)
# uf = UF.new(4)
# uf = 4.to_uf
# ```
struct UnionFind
  getter n : Int32
  getter size : Int32
  getter parent : Array(Int32)
  getter v_size : Array(Int64)
  getter e_size : Array(Int64)
  getter weight : Array(Int64)

  def initialize(n)
    @n = n.to_i                      # 頂点数
    @size = n                        # 連結成分数
    @parent = Array.new(n, &.itself) # 連結成分の根
    @v_size = Array.new(n, 1_i64)    # 連結成分の頂点数
    @e_size = Array.new(n, 0_i64)    # 連結成分の辺数
    @weight = Array.new(n, 0_i64)    # ポテンシャル
  end

  # 経路圧縮を行い、頂点`i`の親番号を返す
  # ```
  # uf = UnionFind.new(4)
  # uf.unite 0, 1
  # uf.unite 1, 2
  # uf.find(0) # => 2
  # ```
  def find(i)
    if i == parent[i]
      i
    else
      ans = find(parent[i])
      weight[i] += weight[parent[i]]
      parent[i] = ans
    end
  end

  # 頂点`i`,`j`の連結判定
  #
  # ```
  # uf = UnionFind.new(4)
  # uf.unite 0, 1, 10
  # uf.unite 1, 2, 20
  # uf.same?(0, 2) # => true
  # uf.same?(0, 3) # => false
  # ```
  def same?(i : Int, j : Int)
    find(i) == find(j)
  end

  def same?(a : Array(Int))
    a.map { |i| find(i) }.uniq.size == 1
  end

  def same?(r : Range(Int, Int))
    r.map { |i| find(i) }.uniq.size == 1
  end

  # 頂点のポテンシャル（重み）
  #
  # ```
  # uf = UnionFind.new(4)
  # uf.unite 0, 1, 10
  # uf.unite 1, 2, 20
  # uf.weight(2) # => 10
  # ```
  def weight(i)
    find(i)
    weight[i]
  end

  # 頂点`i`,`j`のポテンシャル差を求める
  #
  # ```
  # uf = UnionFind.new(4)
  # uf.unite 0, 1, 10
  # uf.unite 1, 2, 20
  # uf.diff(0, 2) # => 30
  # uf.diff(2, 0) # => -30
  # ```
  def diff(i, j)
    weight(j) - weight(i)
  end

  # 頂点`i`と`j`をポテンシャル差`wt`で連結する
  #
  # ```
  # uf = UnionFind.new(4)
  # uf.unite 0, 1, 10
  # uf.unite 1, 2, 20
  # uf.same?(0, 2).should eq true
  # ```
  def unite(i, j, wt = 0_i64)
    i = i.to_i
    j = j.to_i

    wt = wt.to_i64
    wt += weight(i)
    wt -= weight(j)

    i = find(i)
    j = find(j)

    if v_size[i] > v_size[j]
      i, j = j, i
      wt = -wt
    end

    if i == j
      e_size[i] += 1
    else
      @size -= 1
      parent[j] = i
      v_size[i] += v_size[j]
      e_size[i] += e_size[j] + 1
      weight[j] = wt
    end
  end

  # 属する連結成分の頂点数
  #
  # ```
  # uf = UnionFind.new(4)
  # uf.unite(0, 1)
  # uf.unite(1, 2)
  # uf.vertex_size(0) # => 3
  # ```
  def vertex_size(i)
    v_size[find(i)]
  end

  # 別名
  def size(i)
    vertex_size(i)
  end

  # 連結成分の辺数
  #
  # ```
  # uf = UnionFind.new(4)
  # uf.unite(0, 1)
  # uf.unite(1, 2)
  # uf.edge_size(0) # => 2
  # ```
  def edge_size(i)
    e_size[find(i)]
  end

  # 連結成分の親番号を返す
  #
  # ```
  # uf = UnionFind.new(4)
  # uf.unite(0, 1)
  # uf.unite(1, 2)
  # uf.parents # => [2, 3]
  # ```
  def group_parents
    (0...n).select { |i| i == find(i) }
  end

  # 連結成分毎の頂点番号を返す
  #
  # ```
  # uf = UnionFind.new(4)
  # uf.unite(0, 1)
  # uf.unite(1, 2)
  # uf.group_children # => [[0,1,2], [3]]
  # ```
  def group_children
    ix = group_parents.zip(0..).to_h
    ans = Array.new(ix.size) { [] of Int32 }
    n.times do |i|
      ans[ix[find(i)]] << i
    end
    ans
  end

  # 連結成分の頂点数の配列
  #
  # ```
  # uf = UnionFind.new(4)
  # uf.unite(0, 1)
  # uf.unite(1, 2)
  # uf.group_vertex_size # => [3, 1]
  # ```
  def group_vertex_size
    group_parents.map { |i| v_size[i] }
  end

  # 連結成分の辺数の配列
  #
  # ```
  # uf = UnionFind.new(4)
  # uf.unite(0, 1)
  # uf.unite(1, 2)
  # uf.group_edge_size # => [2, 0]
  # ```
  def group_edge_size
    group_parents.map { |i| e_size[i] }
  end

  # デバッグ用：アスキーアートで可視化
  def debug(origin = 1)
    File.open("debug.dot", "w") do |fh|
      fh.puts "digraph tree {"
      group_children.each do |g|
        g.each_cons_pair do |v, nv|
          fh.puts "  #{v + origin} -- #{nv + origin};"
        end
      end
      fh.puts "}"
    end
    puts `cat debug.dot | graph-easy --from=dot --as_ascii`
  end
end

alias UF = UnionFind

struct Int
  def to_uf
    UF.new(self)
  end
end
