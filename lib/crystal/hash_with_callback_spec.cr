require "spec"
require "crystal/hash_with_callback"

describe HashWithCallback do
  it "usage" do
    x = "init"
    ct = HashWithCallback.new(
      on: -> (k : Int64) { x = "on: #{k}" },
      off: -> (k : Int64) { x = "off: #{k}" },
    )
    ct.inc(100_i64)
    x.should eq "on: 100"
    ct.dec(100_i64)
    x.should eq "off: 100"
  end
end
