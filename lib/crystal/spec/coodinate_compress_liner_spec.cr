require "spec"
require "../coodinate_compress_liner"

describe CoodinateCompressLiner do
  it "usage" do
    src = [100, -10, 5, -10]
    cc = CoodinateCompressLiner(Int32).new(src)
    cc.dst.should eq [2, 0, 1, 0]
    cc.ref.should eq [-10, 5, 100]

    i = 2
    cc.ref[cc.dst[i]].should eq src[i]
  end
end
