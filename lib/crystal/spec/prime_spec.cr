require "spec"
require "../prime"

V = [97, 97_i64, 1_000_000_007, 1_000_000_007_i64]

describe Int do
  it "is_prime?" do
    97.is_prime?.should eq true
    97_i64.is_prime?.should eq true
    1_000_000_007.is_prime?.should eq true
    1_000_000_007_i64.is_prime?.should eq true
  end

  it "prime_division" do
    97.prime_division.should eq ({97 => 1})
    97_i64.prime_division.should eq ({97 => 1})
    1_000_000_007.prime_division.should eq ({1_000_000_007 => 1})
    1_000_000_007_i64.prime_division.should eq ({1_000_000_007 => 1})
    1024.prime_division.should eq ({2 => 10})
  end

  it "prime_division map" do
    97.prime_division.map{|k,v|k*v}.should eq [97]
    97_i64.prime_division.map{|k,v|k*v}.should eq [97]
    1_000_000_007.prime_division.map{|k,v|k*v}.should eq [1_000_000_007]
    1_000_000_007_i64.prime_division.map{|k,v|k*v}.should eq [1_000_000_007]
    1024.prime_division.map{|k,v|k*v}.should eq [20]
  end
end
