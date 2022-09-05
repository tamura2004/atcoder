require "spec"
require "crystal/coodinate_compress_liner"

describe CoodinateCompressLiner do
  it "usage" do
    cc = CCL.new
    cc << 100
    cc << -10
    cc << 5
    cc << -10

    cc[-10].should eq 0
    cc[5].should eq 1
    cc[100].should eq 2

    cc.a[0].should eq -10
    cc.a[1].should eq 5
    cc.a[2].should eq 100
  end

  it "add" do
    cc = CCL.new
    cc.add [100,-10,5,-10]

    cc[-10].should eq 0
    cc[5].should eq 1
    cc[100].should eq 2

    cc.a[0].should eq -10
    cc.a[1].should eq 5
    cc.a[2].should eq 100
  end
end
