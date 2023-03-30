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

  it "insert ans size" do
    st = SplayTree(Int32).new
    10.times do |i|
      st << rand(100)
    end
    st.size.should eq 10
  end

  it "split" do
    left = SplayTree(Int32).new
    left << 10
    left << 20
    left << 30
    right = left.split(20)
    left.to_a.should eq [10, 20]
    right.to_a.should eq [30]
  end

  it "split less" do
    left = SplayTree(Int32).new
    left << 10
    left << 20
    left << 30
    right = left.split(20, eq: false)
    left.to_a.should eq [10]
    right.to_a.should eq [20, 30]
  end

  it "split" do
    left = SplayTree(Int32).new
    left << 10
    left << 20
    left << 30
    right = left | 20
    left.to_a.should eq [10, 20]
    right.to_a.should eq [30]
  end


end
