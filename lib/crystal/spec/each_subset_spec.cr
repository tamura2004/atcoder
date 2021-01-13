require "spec"
require "../each_subset"

# bitDPで部分集合を列挙
describe "each_subset" do
  it "usage" do
    s = 0b101
    ans = [] of String
    each_subset(s) do |b|
      ans << sprintf("%03b", b)
    end
    ans.should eq ["101", "100", "001"]
  end
end