require "spec"
require "crystal/diff_hash"

describe DiffHash do
  it "usage" do
    ds = DiffHash.new
    ds[10] = 100
    ds[10].should eq 100
    ds.height.should eq 0
    ds.up 5
    ds.height.should eq 5
    ds[10].should eq 0
    ds[5].should eq 100
    ds[10] = 200
    ds.down 3
    ds[8].should eq 100
    ds[13].should eq 200
  end
end
