require "spec"
require "../union_find_tree"

describe UnionFindTree do
  
  it "usage" do
    s = UnionFindTree.new(6)
    s.size(0).should eq 1
    s.size(3).should eq 1
    s.size(5).should eq 1
    s.same?(0,3).should eq false

    s.unite(0,5)
    s.unite(3,5)
    
    s.size(0).should eq 3
    s.size(3).should eq 3
    s.size(5).should eq 3
    s.same?(0,3).should eq true
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
    ACLPracticeA.new(4,7,query).solve.should eq [0,1,0,1]
  end
end

# https://atcoder.jp/contests/practice2/tasks/practice2_a
alias Query = Tuple(Int32,Int32,Int32)

class ACLPracticeA
  getter n : Int32
  getter q : Int32
  getter query : Array(Query)

  def initialize(@n, @q, @query)
  end

  def solve
    ans = [] of Int32
    set = UnionFindTree.new(n)
    query.each do |(t,u,v)|
      case t
      when 0
        set.unite(u,v)
      when 1
        ans << (set.same?(u,v) ? 1 : 0)
      end
    end
    ans
  end
end

