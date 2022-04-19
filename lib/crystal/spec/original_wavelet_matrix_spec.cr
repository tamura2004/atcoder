require "spec"
require "crystal//original_wavelet_matrix"

describe OriginalWaveletMatrix do
  it "usage" do
    orm = OriginalWaveletMatrix(Int32).new([0, 1, 4, 2, 1, 2, 3])
    orm.rank(1, 5).should eq 2

    orm.kth_smallest(0, 7, 0).should eq 0
    orm.kth_smallest(0, 7, 1).should eq 1
    orm.kth_smallest(0, 7, 2).should eq 1
    orm.kth_smallest(0, 7, 3).should eq 2

    orm.kth_largest(0, 7, 0).should eq 4
    orm.kth_largest(0, 7, 1).should eq 3
    orm.kth_largest(0, 7, 2).should eq 2
    orm.kth_largest(0, 7, 3).should eq 2

    orm.range_freq(0, 7, 3).should eq 5
    orm.range_freq(0, 7, 2).should eq 3

    orm.range_freq(0, 7, 2, 3).should eq 2

    orm.prev_value(0, 7, 4).should eq 3
    orm.prev_value(0, 7, 3).should eq 2
    orm.prev_value(0, 7, 2).should eq 1

    orm.next_value(0, 7, 4).should eq 4
    orm.next_value(0, 7, 3).should eq 3
    orm.next_value(0, 7, 2).should eq 2
  end
end
