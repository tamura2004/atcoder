require "spec"
require "../../../src/main"

describe "main" do
  # cs = [
  #   # {10, 3, [1, 5, 4, 3, 8, 6, 9, 7, 2, 4], 7},
  #   # {1, 0, [1], 1},
  #   # {4, 0, [1, 2, 1, 1], 2},
  #   # {4, 1, [1, 2, 3, 1], 3},
  #   # {9, 5, [1, 6, 11, 1, 16, 21, 2, 3, 4], 6},
  #   {9, 40, [50, 90, 10, 90, 10, 90, 10, 90, 10], 5},
  # ]
  # cs.each do |n, k, a, want|
  #   it "solve" do
  #     Problem.new(n, k, a).solve.should eq want
  #   end
  # end
  it "solve" do
    a = [150000] + [0, 300000] * 10000 + [300000] * 10000
    n = a.size
    k = 150000
    Problem.new(n, k, a).solve.should eq 20001
  end
end
