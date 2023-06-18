require "crystal/st"
require "crystal/cc"

enum Event
  Awake
  Sleep
  Query
end

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

es = [] of Tuple(Int64,Event)
n.times do |i|
  if i.even?
    es << {a[i], Event::Awake}
  else
    es << {a[i], Event::Sleep}
  end
end

q = gets.to_s.to_i64
qs = Array.new(q) do
  l, r = gets.to_s.split.map(&.to_i64)
  {l, r}
end

qs.each do |l, r|
  es << {l, Event::Query}
  es << {r, Event::Query}
end

es.sort!

keys = es.map(&.[0])
cc = CC.new(keys)

values = [] of Int64
state = Event::Awake
pre = 0_i64
es.each do |v, ev|
  next if pre == v

  case ev
  when .sleep?
    values << 0_i64
    pre = v
    state = Event::Sleep
  when .awake?
    values << v - pre
    pre = v
    state = Event::Awake
  when .query?
    case state
    when .awake?
      values << 0_i64
      pre = v
    when .sleep?
      values << v - pre
      pre = v
    end
  end
end

st = values.to_st_sum

qs.each do |l, r|
  if l == r
    pp 0_i64
  else
    pp st[cc[l]...cc[r]]
  end
end

