require "spec"
require "../ext_gcd"

describe "ext_gcd" do
  it "usage" do
    # 2x + 11y = 1 => x = -5, y = 1
    ext_gcd(2, 11).should eq ({-5, 1})
  end
end

describe "mod_inv" do
  it "usage" do
    # 2x = 1 (mod 11) => x = 6
    mod_inv(2, 11).should eq 6
  end
end