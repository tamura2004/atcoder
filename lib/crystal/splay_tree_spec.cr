require "spec"
require "crystal/splay_tree"

describe Node do
  # it "zig-zig" do
  #   #     Z
  #   #    /
  #   #   Y
  #   #  / \
  #   # X   B
  #   #  \
  #   #   A
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   z = Node(String).new("z")
  #   a = Node(String).new("xx")
  #   b = Node(String).new("yy")

  #   z.ch[0] = y
  #   y.ch[0] = x
  #   x.ch[1] = a
  #   y.ch[1] = b

  #   # zig-zig
  #   z.to_s.should eq "((( x ( xx )) y ( yy )) z )"
  #   z.splay("x")
  #   x.to_s.should eq "( x (( xx ) y (( yy ) z )))"
  #   x.splay("z")
  #   z.to_s.should eq "((( x ( xx )) y ( yy )) z )"
  #   z.splay("y")
  #   y.to_s.should eq "(( x ( xx )) y (( yy ) z ))"
  # end

  # it "zig" do
  #   y = Node(String).new("y")
  #   x = Node(String).new("x")
  #   a = Node(String).new("xx")
  #   y.ch[0] = x
  #   x.ch[1] = a
  #   y.to_s.should eq "(( x ( xx )) y )"
  #   y.splay("x")
  #   x.to_s.should eq "( x (( xx ) y ))"
  # end

  # it "split" do
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   z = Node(String).new("z")
  #   x.ch[1] = y
  #   y.ch[1] = z
  #   lo, hi = x | "y"
  #   lo.try(&.to_a).should eq ["x"]
  #   hi.try(&.to_a).should eq ["y", "z"]
  # end

  # it "split not eq" do
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   z = Node(String).new("z")
  #   x.ch[1] = y
  #   y.ch[1] = z
  #   lo, hi = x / "y"
  #   lo.try(&.to_a).should eq ["x", "y"]
  #   hi.try(&.to_a).should eq ["z"]
  # end

  # it "split nil all" do
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   z = Node(String).new("z")
  #   x.ch[1] = y
  #   y.ch[1] = z
  #   lo, hi = x | "a"
  #   lo.should eq nil
  #   hi.try(&.to_a).should eq ["x", "y", "z"]
  # end

  # it "split all nil" do
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   z = Node(String).new("z")
  #   x.ch[1] = y
  #   y.ch[1] = z
  #   lo, hi = x | "zz"
  #   lo.try(&.to_a).should eq ["x", "y", "z"]
  #   hi.should eq nil
  # end

  # it "min max" do
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   z = Node(String).new("z")
  #   x.ch[1] = y
  #   y.ch[1] = z
  #   x.min.val.should eq "x"
  #   x.max.val.should eq "z"
  #   x.minmax(0).val.should eq "x"
  #   x.minmax(1).val.should eq "z"
  #   x.splay(x.max.val)
  #   z.ch[1].should eq nil
  # end

  # it "merge" do
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   z = Node(String).new("z")
  #   x.ch[1] = y
  #   x += z
  #   x.to_a.should eq ["x", "y", "z"]
  # end

  # it "merge" do
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   z = Node(String).new("z")
  #   x = x + y + z
  #   x.to_a.should eq ["x", "y", "z"]
  # end

  it "split" do
    x = Node(String).new("x")
    y = Node(String).new("y")
    z = Node(String).new("z")
    x.ch[1] = y
    y.ch[1] = z
    lo = SplayTree(String).new(x)
    hi = lo | "y"
    lo.to_a.should eq ["x"]
    hi.to_a.should eq ["y", "z"]
  end

  # it "split right all" do
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   z = Node(String).new("z")
  #   x.ch[1] = y
  #   y.ch[1] = z
  #   lo = SplayTree(String).new(x)
  #   hi = lo | "a"
  #   lo.to_a.should eq [] of String
  #   hi.to_a.should eq ["x", "y", "z"]
  # end

  # it "split left all" do
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   z = Node(String).new("z")
  #   x.ch[1] = y
  #   y.ch[1] = z
  #   lo = SplayTree(String).new(x)
  #   hi = lo | "zz"
  #   lo.to_a.should eq ["x", "y", "z"]
  #   hi.to_a.should eq [] of String
  # end

  # it "merge" do
  #   a = Node(String).new("a")
  #   b = Node(String).new("b")
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   a.ch[1] = b
  #   x.ch[1] = y
  #   lo = SplayTree.new(a)
  #   hi = SplayTree.new(x)
  #   lo + hi
  #   lo.to_a.should eq ["a", "b", "x", "y"]
  # end

  # it "merge left nil" do
  #   x = Node(String).new("x")
  #   y = Node(String).new("y")
  #   x.ch[1] = y
  #   lo = SplayTree(String).new)
  #   hi = SplayTree.new(x)
  #   lo + hi
  #   lo.to_a.should eq ["x", "y"]
  # end

  # it "merge right nil" do
  #   a = Node(String).new("a")
  #   b = Node(String).new("b")
  #   a.ch[1] = b
  #   lo = SplayTree.new(a)
  #   hi = SplayTree(String).new)
  #   lo + hi
  #   lo.to_a.should eq ["a", "b"]
  # end

  # it "merge nil nil" do
  #   lo = SplayTree(String).new)
  #   hi = SplayTree(String).new)
  #   lo + hi
  #   lo.to_a.should eq [] of String
  # end

  # it "insert" do
  #   st = SplayTree(Int32).new)
  #   st << 5
  #   st << 1
  #   st << 4
  #   st << 2
  #   st << 3
  #   st.to_a.should eq [1, 2, 3, 4, 5]
  #   st.delete(3).to_a.should eq [1,2,4,5]
  # end
end
