require "spec"
require "../mod_int"

describe ModInt do
  it "+" do
    (1.to_m + 1).should eq 2
    (1.to_m + ModInt::MOD + 7).should eq 8
    (Int64::MAX.to_m + Int64::MAX).should eq 582344006
  end
  
  it "-" do
    (14.to_m - ModInt::MOD - 7).should eq 7
    (Int64::MIN.to_m - Int64::MAX).should eq 417656000
  end
  
  it "*" do
    ((10**9).to_m * (10**9)).should eq 49
    (Int64::MAX.to_m * Int64::MAX).should eq 737564071
  end
  
  it "//" do
    (56.to_m // 7).should eq 8
    ((10**9).to_m // (10**9)).should eq 1
    (Int64::MAX.to_m // Int64::MAX).should eq 1
  end
  
  it "**" do
    (2.to_m ** 0).should eq 1
    (2.to_m ** 1000).should eq 688423210
    (2.to_m ** 1000000000).should eq 140625001
    (2.to_m ** Int64::MAX).should eq 529367677
  end

  it "fact" do
    3.f.should eq 6
    100000.f.should eq 457992974
  end

  it "permutation" do
    3.p(2).should eq 6
  end

  it "combination" do
    3.c(2).should eq 3
    100000.c(2).should eq 999949972
    1000000.c(2).should eq 999496507
  end

  it "repeated combination" do
    4.h(5).should eq 56
  end
end
