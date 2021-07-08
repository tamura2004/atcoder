require "spec"
require "../digit_dp"

describe DigitDP do
  it "usage" do
    a = DigitDP.new("123")
    dp = (0..3).map{ [0] * 2 }
    dp[0][EDGE] = 1

    a.each do |i, from, to, d|
      # pp! [i, from, to, d]
      dp[i+1][to] += dp[i][from]
    end
    dp[-1].sum.should eq 124 # (0..123).size == 124
  end
end
