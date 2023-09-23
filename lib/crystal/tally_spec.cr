require "spec"
require "crystal//tally"

describe "Arrat(T)#tally" do
  it "usage" do
    h = [3, 1, 4, 1, 5].tally
    h.should eq({
      1 => 2_i64,
      3 => 1_i64,
      4 => 1_i64,
      5 => 1_i64,
    })
    h[2].should eq 0_i64
  end

  it "T is Char" do
    h = "abcba".chars.tally
    h.should eq({'a' => 2i64, 'b' => 2i64, 'c' => 1_i64})
    h['d'].should eq 0_i64
  end
end
