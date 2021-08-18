require "spec"
require "../digit_dp"

macro make_array(value, *dims)
  {% for dim in dims %} Array.new({{dim}}) { {% end %}
    {{ value }}
  {% for dim in dims %} } {% end %}
end

describe DigitDP do
  it "usage" do
    dd = DigitDP.new("1203")
    dp = make_array(0_i64, dd.n + 1, 2)
    dp[0][0] = 1_i64
    dd.each do |i, k, d, kk|
      dp[i + 1][kk] += dp[i][k]
    end
    dp[-1].sum.should eq 1204
  end

  it "solve ABC007D" do
    a = "1"
    b = "1000000000000000000"
    solveABC007D(b).should eq 981985601490518016
  end
end

def solveABC007D(s : String)
  dd = DigitDP.new(s)
  dp = make_array(0_i64, dd.n + 1, 2, 2)
  dp[0][0][0] = 1_i64

  dd.each do |i, k, d, kk|
    2.times do |j|
      jj = d == 4 || d == 9 ? 1 : j
      dp[i + 1][jj][kk] += dp[i][j][k]
    end
  end

  dp[-1][-1].sum
end
