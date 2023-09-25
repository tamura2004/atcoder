require "spec"
require "crystal/static_mod_int"

describe StaticModInt do
  it "usage" do
    a = StaticModInt(100).new(13)
    (a * 20).should eq 60
    (a + 20).should eq 33
    (a - 20).should eq 93
    typeof(a * 20).should eq StaticModInt(100)
    typeof(a + 20).should eq StaticModInt(100)
    typeof(a - 20).should eq StaticModInt(100)
  end

  it "not overflow" do
    a = StaticModInt(998244353).new(Int64::MAX) + Int64::MAX
    a.should eq 932051908
    typeof(a).should eq StaticModInt(998244353)
  end
end
