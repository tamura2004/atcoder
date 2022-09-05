require "spec"
require "crystal/cht"

describe CHT do
  it "usage" do
    cht = CHT.new
    [{3,0},{1,2},{-1,8}].sort.reverse_each do |line|
      cht << line
    end
    cht[0].should eq 0
    cht[1].should eq 3
    cht[2].should eq 4
    cht[3].should eq 5
    cht[4].should eq 4
    cht[5].should eq 3
    cht[6].should eq 2
  end
end
