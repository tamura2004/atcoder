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

  it "insert" do
    st = SplayTree(Int32).new
    10.times do |i|
      st << rand(100)
    end
    puts st
  end
end
