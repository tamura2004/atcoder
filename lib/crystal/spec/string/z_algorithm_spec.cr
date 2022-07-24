require "spec"
require "crystal/string/z_algorithm"

describe ZAlgorithm do
  it "usage" do
    ZAlgorithm.new("abcabc").solve.should eq [6, 0, 0, 3, 0, 0]
    ZAlgorithm.new("ababab").solve.should eq [6, 0, 4, 0, 2, 0]
    ZAlgorithm.new("aaaaaa").solve.should eq [6, 5, 4, 3, 2, 1]
    ZAlgorithm.new("ab@cabgab").solve.should eq [9, 0, 0, 0, 2, 0, 0, 2, 0]
  end
end
