require "spec"
require "crystal/abc226/f/problem"
include Abc226::F

describe Abc226::F::Problem do
  it "usage" do
    Problem.new(2,2).solve.should eq 5
    Problem.new(3,3).solve.should eq 79
    Problem.new(50,10000).solve.should eq 77436607

  end
end

