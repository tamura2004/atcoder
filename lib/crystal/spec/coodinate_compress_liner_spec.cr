require "spec"
require "../coodinate_compress_liner"

describe CoodinateCompressLiner do
  it "usage" do
    src = [100, -10, 5, -10]
    cc = CoodinateCompressLiner(Int32).new(src)
    cc[-10].should eq 0
    cc[5].should eq 1
    cc[100].should eq 2
  end
end
