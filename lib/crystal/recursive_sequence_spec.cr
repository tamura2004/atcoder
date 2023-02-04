require "spec"
require "crystal//recursive_sequence"

describe RecursiveSequence do
  it "usage" do
    n = 9
    init = [1, 1]
    RecursiveSequence(Int32).new(n, init) do |a|
      a[-1] + a[-2]
    end.create.should eq [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
  end
end
