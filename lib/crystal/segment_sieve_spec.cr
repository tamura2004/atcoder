require "spec"
require "crystal/segment_sieve"

describe SegmentSieve do
  it "usage" do
    a = 22801763489
    b = 22801787297
    ss = SegmentSieve.new(a, b)
    ss.is_prime_large.count(true).should eq 1001
    ss.is_prime?(a).should eq true
    ss.is_prime?(b).should eq true
  end
end
