require "spec"
require "../memo"

describe Problem do
  it "solve https://atcoder.jp/contests/abc182/tasks/abc182_f/editorial" do
    n = 9_i64
    x = 11837029798_i64
    a = [1,942454037,2827362111,19791534777,257289952101,771869856303,3859349281515,30874794252120,216123559764840].map(&.to_i64)
    Problem.new(n,x,a).solve.should eq 21
  end
end
