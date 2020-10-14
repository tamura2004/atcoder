require "spec"
require "../trie"

describe Trie do
  it "usage" do
    tr = Trie.new
    tr.add("fire")
    tr.add("firearm")
    tr.add("begin")
    tr.add("begnum")

    tr.find("fire").should eq true
    tr.find("begin").should eq true
    tr.find("fireman").should eq false
  end
end
