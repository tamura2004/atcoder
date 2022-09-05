require "spec"
require "crystal/bit_set"

# bitを利用した集合表現
describe Int do
  it "elements" do
    0b1010.elements.to_a.should eq [1, 3]
    0b1010.elements.all?(&.odd?).should eq true
    0b1010.elements.min_of(&.* 7).should eq 7
    0b1010.elements.max_of(&.* 7).should eq 21
  end

  it "each_index" do
    ans = [] of Int32
    0b101.each_index do |i|
      ans << i
    end
    ans.should eq [0, 2]
  end

  it "subsets" do
    0b101.subsets.to_a.should eq [0b101, 0b100, 0b001, 0b000]
  end

  it "each_subset" do
    ans = [] of Int32
    0b101.each_subset { |s| ans << s }
    ans.should eq [0b101, 0b100, 0b001, 0b000]
  end

  it "of" do
    a = [7, 3, 1]
    [0, 2].map(&.of a).should eq [7, 1]
  end

  it "bit index iterator" do
    0b101010.elements.all? do |i|
      i.odd?
    end.should eq true
  end
end
