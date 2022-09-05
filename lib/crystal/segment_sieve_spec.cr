require "spec"
require "crystal/segment_sieve"

describe SegmentSieve do
  it "usage" do
    a = 22801763489
    b = 22801787297
    ss = SegmentSieve.new(a, b).solve
    ss.is_prime.count(true).should eq 1000
  end
end
