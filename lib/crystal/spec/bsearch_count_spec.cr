require "spec"
require "../bsearch_count"

describe "bsearch_count" do
  it "usage" do
    a = [3, 6, 10]
    bsearch_count(a, 1, 2).should eq 0
    bsearch_count(a, 11, 13).should eq 0
    bsearch_count(a, 1, 13).should eq 3
    bsearch_count(a, 3, 6).should eq 1
    bsearch_count(a, 3, 7).should eq 2
    bsearch_count(a, 1, 6).should eq 1
    bsearch_count(a, 10, 16).should eq 1
  end
end
