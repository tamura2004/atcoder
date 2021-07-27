require "spec"
require "../tree"

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

describe Tree do
  # 根からの深さ
  it "usage depth" do
    tr = sample_tree
    tr.depth.should eq [0, 2, 1, 1, 2]
  end

  # 親
  it "usage parent" do
    tr = sample_tree
    tr.parent.should eq [-1, 3, 0, 0, 3]
  end
  
  # 葉
  it "usage leaf" do
    tr = sample_tree
    leaf = tr.leaf
    leaf[4].should eq true
    leaf[0].should eq false
  end
    
  # 次数
  it "usage degree" do
    tr = sample_tree
    degree = tr.degree
    degree[3].should eq 3
    degree[0].should eq 2
  end
    
  # 深さ優先検索
  it "usage dfs" do
    tr = sample_tree
    ans = [] of Int32
    tr.dfs do |v, dir|
      next if dir == 0
      ans << v
    end

    ans.should eq [4, 1, 3, 2, 0]
  end

  # オイラーツアー
  it "usage euler_tour" do
    tr = sample_tree;
    enter, leave, index = tr.euler_tour

    enter.should eq [0, 4, 7, 1, 2]
    leave.should eq [9, 5, 8, 6, 3]
    index.should eq [0, 3, 4, -5, 1, -2, -4, 2, -3, -1]
  end

  # 最小共通祖先
  it "usage lca" do
    tr = sample_tree;
    lca = tr.lca

    lca.call(4,2).should eq 0
    lca.call(1,4).should eq 3
  end
end
