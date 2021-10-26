require "spec"
require "crystal//string_scanner_sample"

alias SSS = StringScannerSample

describe StringScannerSample do
  it "usage" do
    SSS.new("1").expression.should eq 1
    SSS.new("1+2").expression.should eq 3
    SSS.new("1+2*3+4").expression.should eq 11
    SSS.new("1+2*(3+4)").expression.should eq 15
    SSS.new("1+(1+(1+(1+(1+2*3))))").expression.should eq 11
  end
end
