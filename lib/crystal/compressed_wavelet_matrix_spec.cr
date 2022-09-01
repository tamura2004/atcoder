require "spec"
require "crystal/compressed_wavelet_matrix"

def target
  # 1,10,10,100,100,100,..,1000000000
  values = (0..9).map { |i| [10_i64 ** i] * (i + 1) }.flatten
  CompressedWaveletMatrix(Int64).new(values)
end

describe CompressedWaveletMatrix do
  it "[]" do
    mt = target
    mt[0].should eq 1
    mt[1].should eq 10
    mt[2].should eq 10
    mt[3].should eq 100
  end

  it "count" do
    mt = target
    mt.count(0..3, 10).should eq 2
  end

  it "count range" do
    mt = target
    mt.count(0..3, 10i64..100i64).should eq 3
  end

  it "kth smallest" do
    mt = target
    mt.kth_smallest(0..3, 1).should eq 10
  end

  it "kth largest" do
    mt = target
    mt.kth_largest(0..3, 1).should eq 10
  end

  it "less then" do
    mt = target
    mt.less_than(0..3, 10).should eq 1
  end

  it "larger then" do
    mt = target
    mt.larger_than(0..3, 10).should eq 100
  end

  it "ceil" do
    mt = target
    mt.ceil(0..3, 10).should eq 10
  end

  it "floor" do
    mt = target
    mt.floor(0..3, 10).should eq 10
  end
end
