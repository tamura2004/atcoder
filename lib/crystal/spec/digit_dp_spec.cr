require "spec"
require "../digit_dp"

describe DigitDP do
  it "solve ABC007D" do
    a = "1"
    b = "1000000000000000000"
    solveABC007D(b).should eq 981985601490518016
  end
end

macro make_array(*dims)
  {% for dim in dims %} Array.new({{dim}}) { {% end %}
    {{ 0_i64 }}
  {% for dim in dims %} } {% end %}
end

def solveABC007D(s : String)
  a = s.chars.map(&.to_i)
  n = a.size
  dd = DigitDP.new(a)
  dp = make_array(n + 1, 2, 2)
  dp[0][0][0] = 1_i64

  dd.each do |i, k, d, kk|
    2.times do |j|
      jj = d == 4 || d == 9 ? 1 : j
      dp[i + 1][jj][kk] += dp[i][j][k]
    end
  end

  dp[-1][-1].sum
end
