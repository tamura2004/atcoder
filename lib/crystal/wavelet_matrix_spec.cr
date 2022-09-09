require "spec"
require "crystal/wavelet_matrix"

describe WaveletMatrix do
  it "rank" do
    wm = WaveletMatrix(Int32).new([0, 1, 4, 2, 1, 2, 3])
    wm.rank(x: 0, r: 0).should eq 0
    wm.rank(x: 0, r: 1).should eq 1
    wm.rank(x: 1, r: 1).should eq 0
    wm.rank(x: 1, r: 2).should eq 1
    wm.rank(x: 1, r: 5).should eq 2
    wm.rank(2, 3..5).should eq 2
    wm.rank(2, ..5).should eq 2
    wm.rank(2, 3..).should eq 2
  end

  it "rank bug?" do
    wm = WaveletMatrix(Int32).new([0, 1, 2, 1, 1,100])
    wm.rank(4, 0).should eq 0
    wm.rank(4, 4).should eq 0
    wm.rank(4, 0..4).should eq 0

  end

  it "min max" do
    wm = WaveletMatrix(Int32).new([Int32::MAX, Int32::MIN, Int32::MAX, 1, 2, 1, 1,0])
    wm.rank(Int32::MAX, 0).should eq 0
    wm.rank(Int32::MAX, 3).should eq 2
    wm.rank(Int32::MIN, 3).should eq 1
    wm.rank(Int32::MAX, 0..2).should eq 2
    wm.rank(Int32::MIN, 0..2).should eq 1
    wm.rank(0_i64, 0..2).should eq 0
  end

  it "int64" do
    wm = WaveletMatrix(Int64).new([Int64::MAX, Int64::MIN, Int64::MAX, 0_i64])
    wm.rank(Int64::MAX, 0).should eq 0
    wm.rank(Int64::MAX, 3).should eq 2
    wm.rank(Int64::MIN, 3).should eq 1
    wm.rank(Int64::MAX, 0..2).should eq 2
    wm.rank(Int64::MIN, 0..2).should eq 1
  end

  it "kth_smallest" do
    wm = WaveletMatrix(Int32).new([0, 1, 4, 2, 1, 2, 3])

    wm.kth_smallest(0, 7, 0).should eq 0
    wm.kth_smallest(0, 7, 1).should eq 1
    wm.kth_smallest(0, 7, 2).should eq 1
    wm.kth_smallest(0, 7, 3).should eq 2

    wm.kth_smallest(1..4, 2).should eq 2
    wm.kth_smallest(3.., 3).should eq 3
    wm.kth_smallest(..4, 3).should eq 2
  end

  it "kth_largest" do
    wm = WaveletMatrix(Int32).new([0, 1, 4, 2, 1, 2, 3])

    wm.kth_largest(0, 7, 0).should eq 4
    wm.kth_largest(0, 7, 1).should eq 3
    wm.kth_largest(0, 7, 2).should eq 2
    wm.kth_largest(0, 7, 3).should eq 2
  end

  # 未満
  it "range_freq" do
    wm = WaveletMatrix(Int32).new([3, 1, 2])
    wm.range_freq(0, 3, 1).should eq 0
    wm.range_freq(0, 3, 2).should eq 1
    wm.range_freq(0, 3, 3).should eq 2
    wm.range_freq(0, 3, 4).should eq 3
  end

  it "range_freq" do
    wm = WaveletMatrix(Int32).new([0, 1, 4, 2, 1, 2, 3])

    wm.range_freq(..3, 3..).should eq 1

    wm.range_freq(0, 7, 2).should eq 3
    wm.range_freq(0, 7, 3).should eq 5
    wm.range_freq(0, 7, 4).should eq 6
    wm.range_freq(0, 7, 5).should eq 7
    wm.range_freq(0, 7, 6).should eq 7
    wm.range_freq(0, 7, 7).should eq 7

    wm.range_freq(0, 7, 2, 3).should eq 2

    wm.prev_value(0, 7, 4).should eq 3
    wm.prev_value(0, 7, 3).should eq 2
    wm.prev_value(0, 7, 2).should eq 1

    wm.next_value(0, 7, 4).should eq 4
    wm.next_value(0, 7, 3).should eq 3
    wm.next_value(0, 7, 2).should eq 2
  end
end
