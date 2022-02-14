require "spec"
require "crystal/fact_table"

describe FactTable do
  it "fact" do
    3.f.should eq 6
  end

  it "permutation" do
    3.p(2).should eq 6
    2.p(2).should eq 2
    2.p(3).should eq 0
  end

  it "combination" do
    3.c(2).should eq 3
    2.c(2).should eq 1
    2.c(3).should eq 0
  end

  it "repeated combination" do
    4.h(4).should eq 35
    4.h(5).should eq 56
    1.h(5).should eq 1
    2.h(5).should eq 6
  end
end