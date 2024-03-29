require "spec"
require "crystal/cc"

describe CC do
  it "usage" do
    cc = CC.new(keys: [10, 20])
    cc.index(0, eq: true).should eq 0
    cc.index(0, eq: false).should eq 0
    cc.index(10, eq: true).should eq 0
    cc.index(10, eq: false).should eq 1
    cc.index(15, eq: true).should eq 1
    cc.index(15, eq: false).should eq 1
    cc.index(20, eq: true).should eq 1
    cc.index(20, eq: false).should eq 2
    cc.index(25, eq: true).should eq 2
    cc.index(25, eq: false).should eq 2
  end

  it "Int64 array to Int32 Seq" do
    keys = [Int64::MAX, -100_i64, 200_i64, Int64::MIN]
    keys.compress.should eq [3, 1, 2, 0]
  end

  it "to cc" do
    cc = [10, 20].to_cc
    cc.index(0, eq: true).should eq 0
    cc.index(0, eq: false).should eq 0
    cc.index(10, eq: true).should eq 0
    cc.index(10, eq: false).should eq 1
    cc.index(15, eq: true).should eq 1
    cc.index(15, eq: false).should eq 1
    cc.index(20, eq: true).should eq 1
    cc.index(20, eq: false).should eq 2
    cc.index(25, eq: true).should eq 2
    cc.index(25, eq: false).should eq 2
  end

  it "range to tuple" do
    cc = CC.new(keys: [10, 20])
    cc.range_to_tuple(0..0).should eq({0, 0})
    cc.range_to_tuple(0...10).should eq({0, 0})
    cc.range_to_tuple(0..10).should eq({0, 1})
    cc.range_to_tuple(10..10).should eq({0, 1})
    cc.range_to_tuple(10..20).should eq({0, 2})
    cc.range_to_tuple(10...20).should eq({0, 1})
    cc.range_to_tuple(..10).should eq({0, 1})
    cc.range_to_tuple(...10).should eq({0, 0})
    cc.range_to_tuple(..20).should eq({0, 2})
    cc.range_to_tuple(...20).should eq({0, 1})
    cc.range_to_tuple(..30).should eq({0, 2})
    cc.range_to_tuple(...30).should eq({0, 2})
    cc.range_to_tuple(0..).should eq({0, 2})
    cc.range_to_tuple(10..).should eq({0, 2})
    cc.range_to_tuple(20..).should eq({1, 2})
    cc.range_to_tuple(30..).should eq({2, 2})
  end

  it "has_key" do
    cc = CC.new(keys: [10, 20])
    cc.has_key?(0).should eq false
    cc.has_key?(10).should eq true
    cc.has_key?(20).should eq true
    cc.has_key?(30).should eq false
  end

  it "has []" do
    cc = CC.new(keys: [-100, 0, -200, 100])

    cc.round_up(-500).should eq -200
    cc.round_down(-500).should eq nil

    cc.round_down(0).should eq 0
    cc.round_down(0, excludes_end: true).should eq -100

    cc.round_up(50).should eq 100
    cc.round_down(50).should eq 0

    cc.round_up(150).should eq nil
    cc.round_down(150).should eq 100
  end
end
