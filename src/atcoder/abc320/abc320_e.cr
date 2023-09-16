require "crystal/priority_queue"

enum E
  Back
  Go
end

pq_e = PriorityQueue(Tuple(Int64, E, Int64, Int64, Int64)).lesser
pq_u = PriorityQueue(Int64).lesser

n, m = gets.to_s.split.map(&.to_i64)
n.times { |i| pq_u << i }

evs = Array.new(m) {
  t, w, s = gets.to_s.split.map(&.to_i64)
  pq_e << {t, E::Go, w, s, -1i64}
  {t, w, s, -1}
}

ans = Array.new(n, 0_i64)
while pq_e.size > 0
  t, e, w, s, u = pq_e.pop
  case e
  when .go?
    if pq_u.size > 0
      u = pq_u.pop
      ans[u] += w
      pq_e << {t + s, E::Back, -1i64, -1i64, u}
    end
  when .back?
    pq_u << u
  end
end

puts ans.join("\n")
