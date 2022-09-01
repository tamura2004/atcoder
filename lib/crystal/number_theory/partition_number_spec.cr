require "spec"
require "crystal/number_theory/partition_number"
include NumberTheory

describe NumberTheory::PartitionNumber do
  it "usage" do
    ans = [] of Array(Int64)
    PartitionNumber.each(4) do |a|
      ans << a.dup
    end
    ans.should eq [[4], [3], [2, 2], [2], [] of Int64]
  end
end
