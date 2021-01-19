require "spec"
require "../mod_int"

describe ModInt do
  it "usage" do
    ModInt.new(2).**(0).to_i64.should eq 1
    ModInt.new(2).**(1).to_i64.should eq 2
    ModInt.new(2).**(2).to_i64.should eq 4
    ModInt.new(2).**(1000).to_i64.should eq 688423210
    ModInt.new(2).**(1000000000).to_i64.should eq 140625001
  end
end
