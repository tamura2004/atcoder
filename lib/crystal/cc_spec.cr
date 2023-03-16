require "spec"
require "crystal//cc"

describe CC do
  it "usage" do
    cc = CC.new(src: [100, 20, -10, 20])
    cc.keys.should eq [-10,20,100]
    cc[-10].should eq 0
    cc[20].should eq 1
    cc[100].should eq 2
  end
end
