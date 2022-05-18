require "spec"
require "crystal/range_tree"

describe RangeTree do
  it "usage" do
    rt = RangeTree.new([
      {1, 1, 1_i64},
      {1, 3, 2_i64},
      {3, 1, 3_i64},
      {3, 3, 4_i64},
    ])
    rt.query(0, 0, 4, 4).should eq 10
    rt.query(0, 0, 2, 3).should eq 1
    rt.query(0, 0, 2, 4).should eq 3
    rt.query(3, 1, 4, 4).should eq 7
    rt.query(3, 1, 4, 4).should eq 7

    rt[0...4, 0...4].should eq 10
    rt[0..3, 0..3].should eq 10
    rt[..3, ..3].should eq 10

    rt[0...2, 0...3].should eq 1
    rt[0..1, 0..2].should eq 1
    rt[..1, ..2].should eq 1
  end

  it "abc174" do
    rt = RangeTree.new([
      {0, 2, 1_i64},
      {1, 2, 1_i64},
      {2, 2, 1_i64},
    ])

    rt[0..2, 0..2].should eq 1
    # rt[1..3,1..3].should eq 0
    # rt[2..2,2..2].should eq 0
  end
end
