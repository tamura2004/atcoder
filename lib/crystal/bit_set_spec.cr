require "spec"
require "crystal/bit_set"

# bitを利用した集合表現
describe Int do
  it "usage" do
    bs = BitSet.new(0b1010)
    bs.to_i.should eq 0b1010
    bs.includes?(0).should eq false
    bs.includes?(1).should eq true
    bs.includes?(2).should eq false
    bs.includes?(3).should eq true
    0.in?(bs).should eq false
    1.in?(bs).should eq true
    2.in?(bs).should eq false
    3.in?(bs).should eq true
  end

  it "each_subset" do
    bs = BitSet.new(0b1010)
    got = [] of Int32
    bs.each_subset.each do |s|
      got << s.to_i
    end
    got.should eq [10,8,2,0]
  end




  # it "each_index" do
  #   ans = [] of Int32
  #   0b101.each_index do |i|
  #     ans << i
  #   end
  #   ans.should eq [0, 2]
  # end

  # it "subsets" do
  #   0b101.subsets.to_a.should eq [0b101, 0b100, 0b001, 0b000]
  # end

  # it "each_subset" do
  #   ans = [] of Int32
  #   0b101.each_subset { |s| ans << s }
  #   ans.should eq [0b101, 0b100, 0b001, 0b000]
  # end

  # it "of" do
  #   a = [7, 3, 1]
  #   [0, 2].map(&.of a).should eq [7, 1]
  # end

  # it "bit index iterator" do
  #   0b101010.elements.all? do |i|
  #     i.odd?
  #   end.should eq true
  # end
end
