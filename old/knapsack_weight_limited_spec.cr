require "spec"
require "../knapsack_weight_limited"

describe Knapsack::WeightLimited do
  it "usage" do
    input = <<-EOS
    4 5
    2 1 3 2
    3 2 4 2
    EOS
    Knapsack::WeightLimited.read(input).solve.should eq 7
  end
end
