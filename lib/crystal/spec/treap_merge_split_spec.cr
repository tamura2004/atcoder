require "spec"
require "../treap_merge_split"

describe Treap do
  it "usage" do
    Treap.new.class.should eq Treap
  end
end
