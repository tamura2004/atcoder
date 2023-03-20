require "spec"
require "crystal/coodinate_compress_segment_tree_2d"

describe CoodinateCompressSegmentTree do
  it "usage" do
    st = CCST(Int32, Int32).new(
      keys: [10, 20],
      unit: 0
    ) { |x, y| x + y }

    st[10] = 10
    st[20] = 20
    st[0..0].should eq 0
    st[0..1].should eq 0
    st[0...1].should eq 0
    st[0...10].should eq 0
    st[0..10].should eq 10
    st[0..15].should eq 10
    st[0...15].should eq 10
    st[0...20].should eq 10
    st[0..20].should eq 30
    st[0...30].should eq 30
    st[0..30].should eq 30
    st[..0].should eq 0
    st[..1].should eq 0
    st[...1].should eq 0
    st[...10].should eq 0
    st[..10].should eq 10
    st[..15].should eq 10
    st[...15].should eq 10
    st[...20].should eq 10
    st[..20].should eq 30
    st[...30].should eq 30
    st[..30].should eq 30
    st[0...].should eq 30
    st[0..].should eq 30
    st[10...].should eq 30
    st[10..].should eq 30
    st[20...].should eq 20
    st[20..].should eq 20
    st[11..19].should eq 0
    st[11...20].should eq 0
    st[21..39].should eq 0
    st[21..].should eq 0
  end

  it "usage 2d" do
    st = CCST2D(Int32, Int32).new(
      keys: [
        {10, 10},
        {30, 30},
      ],
      unit: 0
    ) { |x, y| x + y }

    st[10, 10] = 10
    st[30, 30] = 20
    st[..5, ..5].should eq 0
    st[..10, ..10].should eq 10
    st[..30, ..30].should eq 30
    st[11...30, 11...30].should eq 0
    st[11..30, 11..30].should eq 20
    st[30.., 30..].should eq 20
    st[31.., 31..].should eq 0
  end
end
