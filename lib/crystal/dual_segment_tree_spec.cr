require "spec"
require "crystal/dual_segment_tree"

alias T = Tuple(Int32,Int32)

describe DualSegmentTree do
  it "usage" do
    st = DualSegmentTree(Int32).new(
      values: [1,2,3,4],
      unit: 0, # default
      f: -> (x : Int32, y : Int32) { Math.max(x, y) } # default
    )
    st[0].should eq 1
    st[1].should eq 2
    st[2].should eq 3
    st[3].should eq 4
    st[1...3] = 10
    st[0].should eq 1
    st[1].should eq 10
    st[2].should eq 10
    st[3].should eq 4
  end

  # 区間xor
  it "initialize with proc" do
    st = DualSegmentTree.new(
      values: [0,1,1,0,1,1],
      unit: 0,
      f: -> (x : Int32, y : Int32) { x ^ y}
    )

    st[0].should eq 0
    st[1].should eq 1
    st[2].should eq 1
    st[3].should eq 0
    
    st[1..4] = 1

    st[0].should eq 0
    st[1].should eq 0
    st[2].should eq 0
    st[3].should eq 1
  end

  it "区間代入" do
    st = DualSegmentTree(Int32).range_assign([1,2,3,4])
    st[0...4] = 10
    st[1...3] = 20
    st[0].should eq 10
    st[1].should eq 20
    st[2].should eq 20
    st[3].should eq 10
    st[3] += 100
    st[3].should eq 110


    st = DualSegmentTree(Int32).range_assign([1,2,3,4])
    st[1...3] = 20
    st[0...4] = 10
    st[0].should eq 10
    st[1].should eq 10
    st[2].should eq 10
    st[3].should eq 10
    # pp st
  end

end
