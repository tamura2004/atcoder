require "crystal/persistent_queue"

n = gets.to_s.to_i
qs = Array.new(n+1, nil.as(PersistentQueue?))
qs[-1] = PersistentQueue.new

n.times do |i|
  cmd, t, x = gets.to_s.split.map(&.to_i64) + [0i64]
  case cmd
  when 0
    if q = qs[t]
      qs[i] = q << x
    end
  when 1
    if q = qs[t]
      ans, qs[i] = q.shift 
      pp ans
    end
  end
end
