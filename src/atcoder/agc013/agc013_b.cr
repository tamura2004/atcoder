require "crystal/graph"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  g. read
end

seen = Set(Int32).new
root = 0
goal = -1
g.each(root){|nv| goal = nv}
ans = Deque.new([root, goal])
seen << root
seen << goal

f = -> (v : Int32, dir : Int32) do
  loop do
    finish = true
    g.each(v) do |nv|
      if !nv.in?(seen)
        seen << nv
        if dir == 0
          ans.unshift nv
        else
          ans << nv
        end
        v = nv
        finish = false
        break
      end
    end
    break if finish
  end
end

f.call(root, 0)
f.call(goal, 1)

pp ans.size
puts ans.to_a.map(&.succ).join(" ")


