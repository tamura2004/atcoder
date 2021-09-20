require "spec"
require "crystal/arc126/c/cs"
include Arc126::C

describe Arc126::C::Cs do
  it "usage" do
    a = [100, 2, 30, 28, 50]
    cs = Cs.new(a)    
    cs[2..30].should eq 2
    cs.cost(3).should eq 6
    cs.cost(10).should eq 10
    cs.cost(99).should eq 384
  end
end
