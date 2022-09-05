require "spec"
require "crystal/string"

describe String do
  it "make suffix array" do
    sa, rank = "abracadabra".suffix_array
    sa.should eq [11, 10, 7, 0, 3, 5, 8, 1, 4, 6, 9, 2]
    rank.should eq [3, 7, 11, 4, 8, 5, 9, 2, 6, 10, 1, 0]
  end
  
  it "sa contain" do
    search = "abracadabra".sa_contain
    search.call("bra").should eq true
    search.call("braz").should eq false
  end
  
  it "lcp" do
    lcp, sa, rank = "abracadabra".lcp
    lcp.should eq [0, 1, 4, 1, 1, 0, 3, 0, 0, 0, 2, 0]
    sa.should eq [11, 10, 7, 0, 3, 5, 8, 1, 4, 6, 9, 2]
    rank.should eq [3, 7, 11, 4, 8, 5, 9, 2, 6, 10, 1, 0]
  end
end
