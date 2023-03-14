require "spec"
require "crystal//dynamic_mod_big_int"

# 剰余の法がInt64を越える場合に対応したModInt
#
# ```
# ModInt.mod = 10.to_big_i ** 100
# a = 10.to_m ** 200 + 7
# a * 2 # => 14
# ```
describe DynamicModBigInt do
  it "usage" do
    mod = 10.to_big_i ** 100
    ModInt.mod = mod
    a = (mod + 7).to_m
    a.should eq 7
    (a + 3).should eq 10
    (a - 3).should eq 4
    (a * 3).should eq 21
    (a ** 3).should eq 343
    a.pow(3).should eq 343
    a.succ.should eq 8
    a.pred.should eq 6

    b = 10.to_m
    (b ** 100 + 7).should eq 7
  end
end
