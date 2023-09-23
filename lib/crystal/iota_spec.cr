require "spec"
require "crystal/iota"

describe "Int#iota" do
  it "usage" do
    10.iota.should eq(1..10)
    10_i64.iota.should eq(1_i64..10_i64)
  end
end
