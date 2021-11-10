require "spec"
require "../prime"

V = [97, 97_i64, 1_000_000_007, 1_000_000_007_i64]

describe Int do
  it "is_prime?" do
    V.each do |v|
      v.is_prime?.should eq true
      v.prime_division.should eq ({v => 1})
      v.prime_factors.should eq [v]
    end
  end
end

describe Prime do
  it "is_prime?" do
    n = Prime::MAX
    Prime.is_prime?(n).should eq false
  end

  it "enumerable" do
    Prime.first(4).to_a.should eq [2, 3, 5, 7]
  end

  it "prime division" do
    Prime.prime_division(72).should eq ({2 => 3, 3 => 2})
  end

  it "prime factors" do
    Prime.prime_factors(72).should eq [2, 3]
  end

  it "each prime factor" do
    ans = [] of Int32
    Prime.each_prime_factor(72) do |i|
      ans << i
    end
    ans.should eq [2, 3]
  end

  it "factors" do
    Prime.factors(12).should eq [1, 2, 3, 4, 6, 12]
  end

  it "each factor" do
    ans = [] of Int32
    Prime.each_factor(12) do |i|
      ans << i
    end
    ans.should eq [1, 12, 2, 6, 3, 4]
  end
end

describe PrimeLarge do
  it "is_prime?" do
    n = 81778177
    PrimeLarge.is_prime?(n).should eq false
  end

  it "prime division" do
    n = 81778177
    want = {13 => 1, 17 => 1, 37 => 1, 73 => 1, 137 => 1}
    PrimeLarge.prime_division(n).should eq want
  end

  it "prime factors" do
    n = 81778177
    PrimeLarge.prime_factors(n).should eq [13, 17, 37, 73, 137]
  end

  it "each prime factor" do
    n = 81778177
    i = 0
    want = [13, 17, 37, 73, 137]
    PrimeLarge.each_prime_factor(n) do |got|
      got.should eq want[i]
      i += 1
    end
  end

  it "factors" do
    n = 81778177
    PrimeLarge.factors(n).should eq [1, 13, 17, 37, 73, 137, 221, 481, 629, 949, 1241, 1781, 2329, 2701, 5069, 8177, 10001, 16133, 30277, 35113, 45917, 65897, 86173, 130013, 170017, 370037, 596921, 1120249, 2210221, 4810481, 6290629, 81778177]
  end
end
