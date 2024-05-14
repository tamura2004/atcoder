require "spec"
require "crystal/segment_tree_beats"

# Node():　デフォルトコンストラクタ。
# Node(T): コンストラクタ。
# initialize(v : T) Node構造体を型Tの値で初期化
# update(l : Node, r : Node) : Nil 子の情報を元に更新する関数。
# push(l : Node, r : Node) : Nil　子に親の情報を遅延して伝える関数。
# apply(x : U) : Bool　作用素を作用させて、更新に成功したらtrue、失敗したらfalseを返す関数。
class Node(T)
  getter fst : T
  getter cnt : Int32
  getter snd : T
  getter lazy : T?
  getter sum : T

  def self.zero
    new(0.as(T))
  end

  def initialize(@fst : T)
    @sum = fst
    @cnt = 1
    @snd = -100
    @lazy = nil.as(Int32?)
  end

  def update(l, r)
    if l.fst == r.fst
      @fst = l.fst
      @cnt = l.cnt + r.cnt
      @snd = Math.max(l.snd, r.snd)
    elsif l.fst < r.fst
      @fst = r.fst
      @cnt = r.cnt
      @snd = l.fst
    else
      @fst = l.fst
      @cnt = l.cnt
      @snd = r.fst
    end
    @sum = l.sum + r.sum
  end

  def push(l, r)
    if x = lazy
      l.add(x)
      r.add(x)
      @lazy = nil.as(Int32?)
    end
  end

  def add(b)
    if a = lazy
      @lazy = Math.min(a, b)
    else
      @lazy = b
    end
  end

  def apply(a)
    if fst <= a
      true
    elsif snd < a
      @sum -= (fst - a) * cnt
      @fst = a
      true
    else
      false
    end
  end
end

describe SegmentTreeBeats do
  it "usage" do
    a = [3, 1, 4, 1, 5]
    values = a.map { |i| Node(Int32).new(i) }
    st = SegmentTreeBeats(Node(Int32)).new(values)

    # ans = 0
    # st.query(0, 5) do |node|
    #   ans += node.sum
    # end
    # ans.should eq 14

    st.apply(0, 5, 2) # => [2, 1, 2, 1, 2]
    pp! st.v

    # ans = 0
    # st.query(0, 5) do |node|
    #   ans += node.sum
    # end
    # ans.should eq 8

    ans = 0
    st.query(2, 3) do |node|
      ans += node.sum
    end
    ans.should eq 2
  end
end
