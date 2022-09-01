require "spec"
require "crystal//string_scanner_sample"

alias SSS = StringScannerSample

describe StringScannerSample do
  it "usage" do
    SSS.new("1").expr.should eq 1
    SSS.new("1+2").expr.should eq 3
    SSS.new("1+2*3+4").expr.should eq 11
    SSS.new("1+2*(3+4)").expr.should eq 15
    SSS.new("1+(1+2*3)").expr.should eq 8
    SSS.new("1+(1+(1+(1+(1+2*3))))").expr.should eq 11
    SSS.new("1234+5432").expr.should eq 6666
    SSS.new("12*11").expr.should eq 132
    SSS.new("(5+7)*(1+5*2)").expr.should eq 132
  end
end
