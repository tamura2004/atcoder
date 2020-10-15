require "spec"
require "../mod_int"

describe ModInt do
  it "usage" do
    ModInt.new(2, 7).**(0).to_i64.should eq 1
    ModInt.new(2, 7).**(1).to_i64.should eq 2
    ModInt.new(2, 7).**(2).to_i64.should eq 4
    ModInt.new(2, 7).**(3).to_i64.should eq 1
    ModInt.new(2, 7).**(10).to_i64.should eq 2
  end
end
