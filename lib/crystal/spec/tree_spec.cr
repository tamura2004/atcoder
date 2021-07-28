require "spec"
require "../tree"

N = 200000

# サンプルツリー
# [1]-[3]
#   `-[4]-[2]
#       `-[5]
def sample_tree
  Tree.new(5) do |tr|
    tr.add 1, 3
    tr.add 1, 4
    tr.add 4, 2
    tr.add 4, 5
  end
end

# 大きな木を３種類試す
def each_type
  [
    :random,
    :bus,
    :uni,
  ].each do |type|
    yield Tree.make(N, type)
  end
end

describe Tree do
  # 幅優先検索
  it "not overflow bfs" do
    each_type do |tr|
      tr.bfs do |v,nv,ans|
        ans[nv] = ans[v] + 1
      end
    end
  end

  # 深さ優先検索
  it "not overflow dfs" do
    each_type do |tr|
      ans = [1] * N
      tr.dfsq do |v, dir, pv|
        next if dir == Tree::ENTER
        ans[pv] += ans[v]
      end
    end
  end

  # 根からの深さ
  it "usage depth" do
    tr = sample_tree
    tr.depth.should eq [0, 2, 1, 1, 2]
    tr.depth(4).should eq [2, 2, 3, 1, 0]
  end

  # 親
  it "usage parent" do
    tr = sample_tree
    tr.parent.should eq [-1, 3, 0, 0, 3]
    tr.parent(4).should eq [3, 3, 0, 4, -1]
  end

  # 葉
  it "usage leaf" do
    tr = sample_tree
    tr.leaf.should eq [false, true, true, false, true]
    tr.leaf(4).should eq [false, true, true, false, false]
  end

  # 次数
  it "usage degree" do
    tr = sample_tree
    tr.degree.should eq [2, 1, 1, 3, 1]
  end

  # オイラーツアー
  it "usage euler_tour" do
    tr = sample_tree
    enter, leave, index = tr.euler_tour

    enter.should eq [0, 4, 7, 1, 2]
    leave.should eq [9, 5, 8, 6, 3]
    index.should eq [0, 3, 4, -5, 1, -2, -4, 2, -3, -1]
  end

  # 最小共通祖先
  it "usage lca" do
    tr = sample_tree
    lca = tr.lca

    lca.call(4, 2).should eq 0
    lca.call(1, 4).should eq 3
  end

  # 部分木の大きさ
  it "usage subtree" do
    tr = sample_tree
    tr.subtree.should eq [5, 1, 1, 3, 1]
    tr.subtree(4).should eq [2, 1, 1, 4, 5]
  end

  # 子ノード
  it "usage children" do
    tr = sample_tree
    tr.children.should eq [[2, 3], [] of Int32, [] of Int32, [1, 4], [] of Int32]
    tr.children(4).should eq [[2], [] of Int32, [] of Int32, [0, 1], [3]]
  end

  # 重心
  it "usage centroid" do
    tr = sample_tree
    tr.centroid.should eq 3
    tr.centroid(4).should eq 3
  end

  # 重心分解
  it "usage centroid decomposition" do
    tr = sample_tree
    centroid, trees = tr.centroid_decomposition
    centroid.should eq 3
    trees.map(&.n).sort.should eq [1, 1, 2]
  end
end

# サンプルツリー
# [1]-[3]
#   `-[4]-[2]
#       `-[5]
