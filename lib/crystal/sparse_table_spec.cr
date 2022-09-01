require "spec"
require "crystal/sparse_table"

describe SparseTable do
  it "min" do
    a = [5, 3, 7, 9, 6, 4, 1, 2, 100]
    sp = SparseTable(Int32).min(a)
    sp[0..2].should eq 3
    sp[2..4].should eq 6
    sp[0..].should eq 1
    sp[7..].should eq 2
    sp[..2].should eq 3
    sp[..0].should eq 5
    sp.solve(0..).should eq 1
    (sp[0..].not_nil! + 1).should eq 2
  end

  it "max" do
    a = [5, 3, 7, 9, 6, 4, 1, 2, 100]
    sp = SparseTable(Int32).max(a)
    sp[0..2].should eq 7
    sp[2..4].should eq 9
    sp[0..].should eq 100
    sp[7..].should eq 100
    sp[..2].should eq 7
    sp[..0].should eq 5
    sp[0..0].should eq 5
    sp[...8].should eq 9
    sp[..8].should eq 100
  end

  it "gcd" do
    a = [6, 8, 12, 4, 9, 18, 15, 20]
    sp = SparseTable(Int32).gcd(a)
    sp[0..2].should eq 2
    sp[2..4].should eq 1
    sp[0..].should eq 1
    sp[7..].should eq 20
    sp[..2].should eq 2
    sp[..0].should eq 6
  end

  it "next change" do
    a = [6, 6, 6, 4, 4, 2, 2, 2, 2, 2, 1]
    sp = SparseTable(Int32).min(a)
    sp.next_change(0, 0).should eq 3
    sp.next_change(0, 1).should eq 3
    sp.next_change(0, 2).should eq 3
    sp.next_change(0, 3).should eq 5
    sp.next_change(0, 4).should eq 5
    sp.next_change(0, 5).should eq 10
    sp.next_change(0, 6).should eq 10
    sp.next_change(0, 7).should eq 10
    sp.next_change(0, 8).should eq 10
    sp.next_change(0, 9).should eq 10
    sp.next_change(0, 10).should eq 11
  end
end
