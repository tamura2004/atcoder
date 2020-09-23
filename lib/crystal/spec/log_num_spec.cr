require "spec"
require "../log_num"

EPS = 0.0000001

describe Int do
  it "f is factorial" do
    want = 5 * 4 * 3 * 2 * 1
    5.f.to_i.should eq want
  end

  it "p is permutation" do
    want = 5 * 4 * 3
    5.p(3).to_i.should eq want
  end

  it "c is combination" do
    want = 5 * 4 * 3 // 3 // 2 // 1
    5.c(3).to_i.should eq want
  end

  it "r is repeated combination" do
    want = 7 * 6 * 5 // 3 // 2 // 1
    5.r(3).to_i.should eq want
  end

  it "log convert Int to LogNum" do
    5.log.class.should eq LogNum
    5.log.to_f.should be_close 5, EPS
  end
end

describe LogNum do
  it "zero * n == n" do
    5.log.should eq LogNum.zero * 5
  end

  it "log a*b == log a + log b" do
    want = LogNum.new(Math.log(5) + Math.log(3))
    (5.log * 3).should eq want
  end 
  
  it "log a*b == log a + log b" do
    want = LogNum.new(Math.log(5) + Math.log(3))
    (5.log * Math.log(3)).should eq want
  end 
  
  it "log a*b == log a + log b" do
    want = LogNum.new(Math.log(5) + Math.log(3))
    (5.log * 3.log).should eq want
  end 

  it "log a/b == log a - log b" do
    want = LogNum.new(Math.log(5) - Math.log(3))
    (5.log / 3).should eq want
  end 
  
  it "log a/b == log a - log b" do
    want = LogNum.new(Math.log(5) - Math.log(3))
    (5.log / Math.log(3)).should eq want
  end 
  
  it "log a/b == log a - log b" do
    want = LogNum.new(Math.log(5) - Math.log(3))
    (5.log / 3.log).should eq want
  end 
  
  it "log a**n == n * log a" do
    want = LogNum.new(Math.log(5) * 6)
    (5.log ** 6).should eq want
  end 

  it "to_f convert from LonInt to f64" do
    (1.log / 2).to_f.should eq 0.5
  end

  it "to_i convert from LonInt to f64" do
    (12.log / 3).to_i.should eq 4
  end
end