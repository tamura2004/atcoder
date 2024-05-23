require "spec"
require "crystal//liner_function"

describe "LinerFunction" do
  it "usage" do
    f = F.new(2.to_m, 1.to_m)
    (f ** 5).should eq (f + f + f + f + f)
    (f ** 7).should eq (f + f + f + f + f + f + f)
    f[5].should eq 11
  end
end
