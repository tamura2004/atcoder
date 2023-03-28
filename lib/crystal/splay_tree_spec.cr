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

    z.lch = y
    y.lch = x

    # zig-zig
    z.to_s.should eq "(z (y (x  ) ) )"
    z.splay("x")
    x.to_s.should eq "(x  (y  (z  )))"
  end
end
