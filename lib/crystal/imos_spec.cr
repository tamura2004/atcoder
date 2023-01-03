require "spec"
require "crystal/imos"
require "crystal/indexable"

describe IMOS do
  it "usage" do
    imos = IMOS(Int32).new(10)
    imos[-10..5] = 10
    imos[3...7] = 20
    imos[113...700] = 20
    imos.update!
    imos[0].should eq 10
    imos[1].should eq 10
    imos[2].should eq 10
    imos[3].should eq 30
    imos[4].should eq 30
    imos[5].should eq 30
    imos[6].should eq 20
    imos[7].should eq 0
  end
end
