require "spec"
require "crystal/sparse_table_2d"

describe SparseTable2D do
  it "initialize" do
    values = [
      [0, 1, 2],
      [3, 4, 5],
    ]
    SparseTable2D(Int32).new(values, &Math.min)
  end
end
