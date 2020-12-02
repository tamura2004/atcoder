require "spec"
require "../treap_insert_erace"

describe Treap do
  it "usage insert" do
    tr = Treap.new
    10.times do |i|
      tr << i * 2
    end
    10.times do |i|
      tr.kth_element(i+1).try(&.val).should eq i * 2
    end
  end
end
