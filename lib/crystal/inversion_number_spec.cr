require "spec"
require "crystal/inversion_number"

describe InversionNumber do
  it "usage" do
    [1_000_000_000, 500_000_000, 200_000_000].inversion_number.should eq 3
    [5, 4, 3, 2, 1].inversion_number.should eq 10
    [5, 1, 4, 2, 3].inversion_number.should eq 6
    [Int64::MAX, 0_i64, Int64::MIN].inversion_number.should eq 3
    (0_i64...500_000_i64).to_a.reverse.inversion_number.should eq 124999750000_i64
  end
end
