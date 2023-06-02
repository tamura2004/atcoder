require "spec"
require "crystal/segment_tree_beats"

class Node(T)
  getter fst : T
  getter cnt : Int32
  getter snd : T
  getter lazy : T?
  getter sum : T

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
    a = [10, 10, 10, 10, 10, 10]
    values = a.map { |i| Node(Int32).new(i) }
    stb = SegmentTreeBeats(Node(Int32)).new(values)

    [{0,6,20,60},{1,5,5,40},{2,4,2,34}].each do |l, r, x, want|
      stb.apply(l, r, x)
      ans = 0
      stb.query(0, 8) do |node|
        ans += node.sum
      end
      ans.should eq want
    end
  end
end
