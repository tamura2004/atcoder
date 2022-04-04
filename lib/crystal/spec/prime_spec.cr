require "spec"
require "crystal/prime"

describe Prime do
  it "iterate" do
    Prime.first(4).to_a.should eq [2,3,5,7]
    Prime.first(4_i64).to_a.should eq [13,17,19,23]
  end
end

describe Int32 do
  it "is_prime?" do
    {
                 97 => true,
      1_000_000_007 => true,
                 96 => false,
      1_000_000_008 => false,
    }.each do |n, want|
      n.is_prime?.should eq want
      n.to_i64.is_prime?.should eq want
    end
  end

  it "prime_division" do
    {
                 97 => {97 => 1},
      1_000_000_007 => {1_000_000_007 => 1},
                 96 => {2 => 5, 3 => 1},
      1_000_000_008 => {2 => 3, 3 => 2, 7 => 1, 109 => 2, 167 => 1},
    }.each do |n, want|
      n.prime_division.should eq want
      n.to_i64.prime_division.should eq want
    end
  end

  it "prime_division map" do
    {
                 97 => [97],
      1_000_000_007 => [1_000_000_007],
                 96 => [32, 3],
      1_000_000_008 => [8, 9, 7, 11881, 167],
    }.each do |n, want|
      n.prime_division.map { |k, v| k**v }.should eq want
      n.to_i64.prime_division.map { |k, v| k**v }.should eq want
    end
  end

  it "prime_factors" do
    {
                 97 => [97],
      1_000_000_007 => [1_000_000_007],
                 96 => [2, 3],
      1_000_000_008 => [2, 3, 7, 109, 167],
    }.each do |n, want|
      n.prime_factors.should eq want
      n.to_i64.prime_factors.should eq want
    end
  end

  it "factors" do
    {
                 97 => [1, 97],
      1_000_000_007 => [1, 1_000_000_007],
                 96 => [1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 96],
      1_000_000_008 => [1, 2, 3, 4, 6, 7, 8, 9, 12, 14, 18, 21, 24, 28, 36, 42, 56, 63, 72, 84, 109, 126, 167, 168, 218, 252, 327, 334, 436, 501, 504, 654, 668, 763, 872, 981, 1002, 1169, 1308, 1336, 1503, 1526, 1962, 2004, 2289, 2338, 2616, 3006, 3052, 3507, 3924, 4008, 4578, 4676, 6012, 6104, 6867, 7014, 7848, 9156, 9352, 10521, 11881, 12024, 13734, 14028, 18203, 18312, 21042, 23762, 27468, 28056, 35643, 36406, 42084, 47524, 54609, 54936, 71286, 72812, 83167, 84168, 95048, 106929, 109218, 127421, 142572, 145624, 163827, 166334, 213858, 218436, 249501, 254842, 285144, 327654, 332668, 382263, 427716, 436872, 499002, 509684, 655308, 665336, 748503, 764526, 855432, 998004, 1019368, 1146789, 1310616, 1497006, 1529052, 1984127, 1996008, 2293578, 2994012, 3058104, 3968254, 4587156, 5952381, 5988024, 7936508, 9174312, 11904762, 13888889, 15873016, 17857143, 23809524, 27777778, 35714286, 41666667, 47619048, 55555556, 71428572, 83333334, 111111112, 125000001, 142857144, 166666668, 250000002, 333333336, 500000004, 1000000008],
    }.each do |n, want|
      n.factors.should eq want
      n.to_i64.factors.should eq want
    end
  end

  # 三角数
  it "trinum" do
    1.trinum_index.should eq 1
    2.trinum_index.should eq 1
    3.trinum_index.should eq 2
    4.trinum_index.should eq 2
    5.trinum_index.should eq 2
    6.trinum_index.should eq 3
    7.trinum_index.should eq 3
    8.trinum_index.should eq 3
    9.trinum_index.should eq 3
    10.trinum_index.should eq 4

    1.trinum.should eq 1
    2.trinum.should eq 3
    3.trinum.should eq 6
    4.trinum.should eq 10
  end
end
