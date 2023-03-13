require "spec"
require "crystal/ext_gcd"

describe "ext_gcd" do
  it "usage" do
    # 2x + 11y = 1 => x = -5, y = 1
    ext_gcd(2, 11).should eq ({-5, 1, 1})

    # 14x + 18y = 2 => x = 4, y = -3
    ext_gcd(14, 18).should eq ({4, -3, 2})
  end
end

describe "mod_inv" do
  it "usage" do
    # 2x = 1 (mod 11) => x = 6
    mod_inv(2, 11).should eq 6
  end
end

describe "crt" do
  it "usage" do
    # x = 3 (mod 6)
    # x = 1 (mod 4) # => x = 9 (mod 12)
    crt(3, 6, 1, 4).should eq ({9, 12})
    crt(3, 6, 2, 4).should eq nil
  end

  it "overflow" do
    b1 = 999_999_999_i64
    m1 = 2_000_000_098_i64
    b2 = 1_000_000_037_i64
    m2 = 1_000_000_500_i64
    crt(b1, m1, b2, m2)
  end
end
