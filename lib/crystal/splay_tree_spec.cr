require "spec"
require "crystal/splay_tree"

describe SplayTree do
  it "zig" do
    up = Node.new("up")
    me = Node.new("me")
    hi = Node.new("hi")

    up.lo = me
    me.hi = hi

    pp! me
    pp! up
    me.zig
    pp! up
  end
end
