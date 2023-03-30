require "spec"
require "crystal/splay_tree"

describe Node do
  it "zig-zig" do
    #     Z
    #    /
    #   Y
    #  / \
    # X   B
    #  \
    #   A
    z = Node(String).new("z")
    y = Node(String).new("y")
    x = Node(String).new("x")
    a = Node(String).new("xx")
    b = Node(String).new("yy")

    z.ch[0] = y
    y.ch[0] = x
    x.ch[1] = a
    y.ch[1] = b

    # zig-zig
    z.to_s.should eq "((( x ( xx )) y ( yy )) z )"
    z.splay("x")
    x.to_s.should eq "( x (( xx ) y (( yy ) z )))"
    x.splay("z")
    z.to_s.should eq "((( x ( xx )) y ( yy )) z )"
    z.splay("y")
    y.to_s.should eq "(( x ( xx )) y (( yy ) z ))"
  end

  it "zig" do
    y = Node(String).new("y")
    x = Node(String).new("x")
    a = Node(String).new("xx")
    y.ch[0] = x
    x.ch[1] = a
    y.to_s.should eq "(( x ( xx )) y )"
    y.splay("x")
    x.to_s.should eq "( x (( xx ) y ))"
  end

  it "split" do
    x = Node(String).new("x")
    y = Node(String).new("y")
    z = Node(String).new("z")
    x.ch[1] = y
    y.ch[1] = z
    lo = SplayTree(String).new(x)
    hi = lo | "y"
    lo.to_a.should eq ["x", "y"]
    hi.to_a.should eq ["z"]
  end

  it "split" do
    x = Node(String).new("x")
    y = Node(String).new("y")
    z = Node(String).new("z")
    x.ch[1] = y
    y.ch[1] = z
    lo = SplayTree(String).new(x)
    hi = lo | "a"
    lo.to_a.should eq [] of String
    hi.to_a.should eq ["x", "y","z"]
  end
end
