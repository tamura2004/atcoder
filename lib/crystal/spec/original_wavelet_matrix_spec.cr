require "spec"
require "crystal/original_wavelet_matrix"

describe OriginalWaveletMatrix do
  it "rank" do
    orm = OriginalWaveletMatrix(Int32).new([0, 1, 4, 2, 1, 2, 3])
    orm.rank(x: 0, r: 0).should eq 0
    orm.rank(x: 0, r: 1).should eq 1
    orm.rank(x: 1, r: 1).should eq 0
    orm.rank(x: 1, r: 2).should eq 1
    orm.rank(x: 1, r: 5).should eq 2
    orm.rank(2, 3..5).should eq 2
    orm.rank(2, ..5).should eq 2
    orm.rank(2, 3..).should eq 2
  end

  it "kth_smallest" do
    orm = OriginalWaveletMatrix(Int32).new([0, 1, 4, 2, 1, 2, 3])

    orm.kth_smallest(0, 7, 0).should eq 0
    orm.kth_smallest(0, 7, 1).should eq 1
    orm.kth_smallest(0, 7, 2).should eq 1
    orm.kth_smallest(0, 7, 3).should eq 2

    orm.kth_smallest(1..4, 2).should eq 2
    orm.kth_smallest(3.., 3).should eq 3
    orm.kth_smallest(..4, 3).should eq 2
  end

  it "kth_largest" do
    orm = OriginalWaveletMatrix(Int32).new([0, 1, 4, 2, 1, 2, 3])

    orm.kth_largest(0, 7, 0).should eq 4
    orm.kth_largest(0, 7, 1).should eq 3
    orm.kth_largest(0, 7, 2).should eq 2
    orm.kth_largest(0, 7, 3).should eq 2
  end

  # 未満
  it "range_freq" do
    orm = OriginalWaveletMatrix(Int32).new([3, 1, 2])
    orm.range_freq(0, 3, 1).should eq 0
    orm.range_freq(0, 3, 2).should eq 1
    orm.range_freq(0, 3, 3).should eq 2
    orm.range_freq(0, 3, 4).should eq 3
  end

  it "range_freq" do
    orm = OriginalWaveletMatrix(Int32).new([0, 1, 4, 2, 1, 2, 3])

    orm.range_freq(..3, 3..).should eq 1

    orm.range_freq(0, 7, 2).should eq 3
    orm.range_freq(0, 7, 3).should eq 5
    orm.range_freq(0, 7, 4).should eq 6
    orm.range_freq(0, 7, 5).should eq 7
    orm.range_freq(0, 7, 6).should eq 7
    orm.range_freq(0, 7, 7).should eq 7

    orm.range_freq(0, 7, 2, 3).should eq 2

    orm.prev_value(0, 7, 4).should eq 3
    orm.prev_value(0, 7, 3).should eq 2
    orm.prev_value(0, 7, 2).should eq 1

    orm.next_value(0, 7, 4).should eq 4
    orm.next_value(0, 7, 3).should eq 3
    orm.next_value(0, 7, 2).should eq 2
  end
end
