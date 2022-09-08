require "crystal/graph"
require "crystal/graph/euler_tour"

n = gets.to_s.to_i
g = Graph.new(n)
(n-1).times do
  g.read
end

enter, leave, events = EulerTour.new(g, 0).solve

lo = Array.new(n, 0)
hi = Array.new(n, 0)
id = 0

pre = EulerTour::Event::Leave
events.each_with_index do |(v, ev), i|
  case ev
  when .enter?
    id += 1 if pre.leave?
    lo[v] = id
    pre = EulerTour::Event::Enter
  when .leave?
    hi[v] = id
    pre = EulerTour::Event::Leave
  end
end

n.times do |v|
  puts "#{lo[v]} #{hi[v]}"
end

