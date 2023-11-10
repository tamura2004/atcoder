require "crystal/lst"

n, d, w = gets.to_s.split.map(&.to_i)
ts = [] of Int32
tx = Array.new(n) do
  t, x = gets.to_s.split.map(&.to_i.pred)
  ts << t
  { t, x }
end.sort
tx = Deque.new(tx)
work = Deque(Tuple(Int32,Int32)).new
ts = ts.uniq.sort

values = Array.new(200_001,0)
st = LST(Int32,Int32).new(
  values: values,
  fxx: ->Math.max(Int32,Int32),
  fxa: -> (x : Int32, a : Int32) { x + a },
  faa: -> (a : Int32, b : Int32) { a + b },
)

ans = 0

ts.each do |t|
  while tx.size > 0 && tx[0][0] < t + d
    apple = tx.shift
    st[apple[1]...apple[1]+w] = 1
    work << apple
  end
  
  chmax ans, st[0..]
  
  while work.size > 0 && work[0][0] == t
    apple = work.shift
    st[apple[1]...apple[1]+w] = -1
  end
end

pp ans


