require "spec"
require "../digit_dp"

describe DigitDpProblem do
  it "solve ABC154" do
    DigitDpProblem(Int64).read("100 1").solve.should eq 19
    DigitDpProblem(Int64).read("25 2").solve.should eq 14
    DigitDpProblem(Int64).read("314159 2").solve.should eq 937
    DigitDpProblem(Int64).read("9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 3").solve.should eq 117879300
  end
end
