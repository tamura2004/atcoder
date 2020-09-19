{% if env("DEBUG") %}
  require "debug"
  require "../lib/crystal/test_helper"
  include Random::Secure
{% else %}
  macro debug!(content)
  end
{% end %}

class Tree(T)
  getter n : Int32
  getter g : Array(Array(T))
  property parent : Array(T)
  property dist : Array(T)
 
  def initialize(@n,@g)
    @parent = Array(T).new(n, -1)
    @dist = Array(T).new(n, -1)
    bfs 0
  end
  
  def bfs(root)
    begin
      v = 0
      nv = 0
      que = [root]
      dist[root] = 0
      while que.size > 0
        v = que.shift
        d = dist[v]
        g[v].each do |nv|
          next if dist[nv] != -1
          dist[nv] = d + 1
          parent[nv] = v
          que << nv
        end
      end
    rescue
      debug! v
      debug! nv
      debug! self
    end
  end
end

n = 5
a = [[1,2],[3,4],[] of Int32,[] of Int32,[] of Int32]
t = Tree(Int32).new(n,a)
