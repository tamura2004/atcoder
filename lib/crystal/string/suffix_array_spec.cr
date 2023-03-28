require "spec"
require "crystal/string/suffix_array"

describe "suffix_array" do
  it "usage" do
    sa, rank, lcp = SuffixArray.new("abcba").solve
    # 0, 5, ""
    # 1, 4, "a"
    # 2, 0, "abcba"
    # 3, 3, "ba"
    # 4, 1, "bcbaa"
    # 5, 2, "cba"
    sa.should eq [5, 4, 0, 3, 1, 2]
    rank.should eq [2, 4, 5, 3, 1, 0]
    lcp.should eq [0, 1, 0, 1, 0, 0]
  end
end
