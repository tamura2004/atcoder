require "spec"
require "../trie"

describe Trie do
  it "usage" do
    tr = Trie(Int64).new
    tr["aa"] = 100_i64
    tr["az"] = 100_i64
    tr["aza"] = 100_i64
    tr.count("az").should eq 2
    tr.delete("az")
    tr.count("az").should eq 1
    tr.includes?("aza").should eq true
    tr.includes?("a").should eq false
    tr["b"].should eq nil
    # tr.add("firearm")
    # tr.add("begin")
    # tr.add("begnum")
    # tr.add("findjob")
    # tr.add("fixnum")

    # tr.get("fire").should eq 1
    # tr.find("begin").should eq true
    # tr.find("fireman").should eq false

    # tr.count("fi").should eq 4
  end
end
