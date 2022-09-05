require "spec"
require "crystal/succinct_indexable_dictionary"

describe SuccinctIndexableDictionary do
  it "usage" do
    sid = SID.new(10)
    sid.set(3)
    sid.set(7)
    sid.build

    sid[2].should eq false
    sid[3].should eq true

    sid.rank(3).should eq 0
    sid.rank(4).should eq 1
    sid.rank(5).should eq 1
    sid.rank(6).should eq 1
    sid.rank(7).should eq 1
    sid.rank(8).should eq 2
    sid.rank(9).should eq 2
    sid.rank(10).should eq 2
    sid.rank(11).should eq 2
    sid.rank(false, 5).should eq 4
    sid.rank(false, 6).should eq 5

    sid.select(2).should eq 7
    sid.select(false, 7).should eq 8
  end
end
