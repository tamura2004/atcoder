require "spec"
require "crystal/merge_sort_tree"

describe MergeSortTree do
  it "usage" do
    # abc339_g
    mst = MergeSortTree.new([2, 0, 2, 4, 0, 2, 0, 3])
    pp! mst
    mst.range_sum_under(0, 8, 3).should eq 9
  end
end
