require "spec"
require "crystal//math"

describe Math do
  it "usage" do
    Math.isqrt(999_999_999_999_999_999).should eq 999_999_999
    Math.sqrt(999_999_999_999_999_999).to_i64.should eq 1_000_000_000
  end
end
