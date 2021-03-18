require "spec"
require "../bit_set"

describe Int do
  it "割り切るか" do
    3.div?(12).should eq true
    3.div?(7).should eq false
  end

  it "部分集合の列挙（空集合除く）" do
    3.subsets.to_a.should eq [0b11, 0b10, 0b01]
  end

  it "真部分集合の列挙（空集合除く）" do
    3.proper_subsets.to_a.should eq [0b10, 0b01]
  end

  it "指定サイズの部分集合の辞書順列挙" do
    3.fix_size_subsets(2).to_a.should eq [0b011, 0b101, 0b110]
  end

  it "ビット位置の列挙" do
    10.bits.to_a.should eq [1, 3]
  end

  it "ゼロ埋め*n*桁指定での２進数表記" do
    10.to_bit(4).should eq "1010"
  end

  it "補集合" do
    10.inv(4).should eq 0b0101
  end

  it "flip Array#at" do
    1.of([4, 7, 1]).should eq 7
  end

  it "on" do
    0b1010.on(2).should eq 0b1110
    0b1010.on(1).should eq 0b1010
  end

  it "off" do
    0b1010.off(1).should eq 0b1000
    0b1010.off(2).should eq 0b1010
  end

  it "flip" do
    0b1010.off(1).should eq 0b1000
    0b1010.off(2).should eq 0b1010
  end

  it "lsb" do
    0b1010.lsb.should eq 0b0010
  end
end

describe BitSet do
  it "ブロックの評価値で初期化" do
    BitSet(3).make(&.odd?).should eq 0b010
  end

  it "真偽値の配列で初期化" do
    BitSet(3).make([true, false, false]).should eq 0b001
  end

  it "グラフの隣接リスト(0-indexed)から初期化" do
    BitSet(3).make([1, 2]).should eq 0b110
  end
end
