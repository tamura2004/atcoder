require "crystal/neko_set"

n = gets.to_s.to_i64
lra = Array.new(n) do
  l, r, a = gets.to_s.split.map(&.to_i64)
  l -= 1
  r -= 1
  { l, r, a }
end
q = gets.to_s.to_i64
xs = gets.to_s.split.map(&.to_i64.pred)
ans = Array.new(q, 0_i64)
ns = NekoSet.new

enum Event
  Enter
  Eval
  Leave
end

events = [] of Tuple(Int64, Event, Int64)
lra.each do |l, r, a|
  events << { l, Event::Enter, a }
  events << { r, Event::Leave, a }
end
xs.each_with_index do |x, i|
  events << { x, Event::Eval, i.to_i64 }
end

events.sort!
events.each do |x, event, a|
  case event
  when Event::Enter
    ns.inc(a)
  when Event::Eval
    ans[a] = ns.mex
  when Event::Leave
    ns.dec(a)
  end
end

puts ans.join("\n")