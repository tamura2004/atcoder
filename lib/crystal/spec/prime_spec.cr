require "spec"
require "../prime"

describe Int do
  it "prime?" do
    7.prime?.should eq true
    6.prime?.should eq false
  end

  it "div?" do
    3.div?(6).should eq true
    3.div?(7).should eq false
  end

  it "prime_division" do
    71.prime_division.should eq ({71 => 1})
    72.prime_division.should eq ({2 => 3, 3 => 2})
  end

  it "prime_factor" do
    71.prime_factor.should eq Set{71}
    72.prime_factor.should eq Set{2, 3}
  end

  it "factor_num" do
    71.factor_num.should eq 2
    72.factor_num.should eq 12
  end
end

describe Hash do
  it "*" do
    a = {2 => 1, 3 => 2}
    b = {2 => 2, 5 => 2}
    (a * b).should eq ({2 => 3, 3 => 2, 5 => 2})
  end

  it "to_i" do
    a = {2 => 1, 3 => 2}
    a.to_i.should eq 18
  end
end

describe Prime do
  it "usage" do
    Prime.first(4).to_a.should eq [2, 3, 5, 7]
  end

  it "双子素数" do
    ans = Prime.take_while(&.<= 40).each_cons(2).select do |(i,j)|
      (i - j).abs <= 2
    end.to_a
    ans.should eq [[17, 19], [29, 31]]
  end
end
