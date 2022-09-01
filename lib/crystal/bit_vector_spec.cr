require "spec"
require "crystal//bit_vector"

describe BitVector do
  it "usage" do
    b = BitVector.new(7000)
    1000.times do |i|
      b.set(i * 7)
    end
    b.build
    b.rank(63).should eq 10
    b.select(10).should eq 63
    b.rank(7000).should eq 1000
    b.select(1000).should eq 6993
  end
end
